import 'package:flutter/material.dart';
import 'package:flutter_app/demoPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'shelfButton.dart';
import 'systemPage.dart';
import 'package:flutter_app/plantReading.dart';
import 'package:http/http.dart' as http;
import 'services.dart';
import 'textWidget.dart';
import 'dart:convert';
import 'demoPage.dart';
import 'growGuide.dart';
import 'profilePage.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
///For more information on how to work with notifications, check these out:
/// - https://pub.dev/packages/flutter_local_notifications#-readme-tab-
/// - https://www.youtube.com/watch?v=xMeCwF5MO6w


///Main page of the app

class HomePage extends StatefulWidget {
  final String _font;

  ///Constructor
  HomePage(this._font);

  @override
  State<StatefulWidget> createState() => _HomePage(_font);
}

class _HomePage extends State<HomePage> {
  final String _font;
  Icon searchOrCancelIcon = const Icon(Icons.search);
  Widget titleText;
  ShelfButton shelf1;
  ShelfButton shelf2;
  ShelfButton shelf3;
  List<Widget> listedShelves = [];

  @override
  void initState() {
    super.initState();

    ///Initializing settings for notifications
    final androidSettings = AndroidInitializationSettings('notif_icon');
    final iOSSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => notificationSelected(payload));

    notifPlugin.initialize(InitializationSettings(androidSettings, iOSSettings), onSelectNotification: notificationSelected);

    shelf1 = ShelfButton('Shelf 1', Colors.amberAccent, FontAwesomeIcons.solidSun, _font, 1);
    shelf2 = ShelfButton('Shelf 2', Colors.lightGreen, FontAwesomeIcons.seedling, _font, 2);
    shelf3 = ShelfButton('Shelf 3', Colors.lightBlue, FontAwesomeIcons.water, _font, 3);
    listedShelves.addAll([shelf1, shelf2, shelf3]);

    displayReminderNotifPeriodically();
    titleText = Text(
        'ZotPonics',
        style: TextStyle(
            height: 2,
            fontFamily: _font,
            fontWeight: FontWeight.w700,
            fontSize: 40.0,
            color: Colors.white)
    );
  }

  ///Plugin to handle notifications
  FlutterLocalNotificationsPlugin notifPlugin = FlutterLocalNotificationsPlugin();

  ///When notification is tapped, this function is run
  Future notificationSelected(String payload) async => await Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomePage(_font))
  );

  ///Displays reminder notifications
  Future displayReminderNotifPeriodically() {
    ///Notification setup
    var time = Time(12, 0, 0); ///Notification appears biweekly Sunday at 12:00
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Channel ID', 'ZotPonics', 'Channel Description',
        importance: Importance.Default,
        priority: Priority.Default,
        ticker: 'Replace your nutrient water!');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    ///Biweekly notifications handled by modified package code in directory
    notifPlugin.showWeeklyAtDayAndTime(0, 'ZotPonics', 'Replace your nutrient water!', Day.Sunday, time, RepeatInterval.Biweekly, platformChannelSpecifics);
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  Future<List<String>> getProfileNames(int shelfNum) async {
    final response = await http.get(Uri.parse(url + plantData + shelfNum.toString()));
    List<String> profileNames = [];

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      List<PlantReading> readings = list.map((i) => PlantReading.fromJson(i)).toList();
      for (int i = 0; i < readings.length; i++) {
        profileNames.add(readings[i].name);
      }
    } else {
      return profileNames;
    }
    return profileNames;
  }

  ///Updates list of shelves to display based on user's inputted search
  void updateListedShelves(String searchText) async {
    listedShelves.removeRange(0, listedShelves.length);
    searchText = searchText.toLowerCase();

    ///No search returns back to default list of shelves
    if (searchText == '') {
      listedShelves = [shelf1, shelf2, shelf3];
      return;
    }

    ///Numeric values search for a specific shelf number
    if (isNumeric(searchText)) {
      switch (searchText) {
        case '1': { listedShelves = [shelf1]; return; }
        case '2': { listedShelves = [shelf2]; return; }
        case '3': { listedShelves = [shelf3]; return; }
        default: { listedShelves = [Align(
          alignment: Alignment.center,
          child: Container(
            child: Text(
                'No Results',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 2,
                    fontFamily: _font,
                    fontWeight: FontWeight.w700,
                    fontSize: 40.0)
            ),
          ),
        )];}
        return;
      }
    }

    ///Search through shelves by plant name
    List<ShelfButton> allShelves = [shelf1, shelf2, shelf3];
    for(int shelfIndex = 0; shelfIndex < allShelves.length; shelfIndex++) {
      ///Get profile names from database.
      List<String> profileNames = await getProfileNames(shelfIndex+1);
      setState(() {}); ///Refresh state to display actual results.

      for(int profileIndex = 0; profileIndex < profileNames.length; profileIndex++) {
        if (searchText == profileNames[profileIndex].toLowerCase()) {
          listedShelves.add(allShelves[shelfIndex]);
          break;
        }
      }
    }

    ///If search text is not found then display "No Results"
    if (listedShelves.isEmpty) {
      listedShelves = [Align(
        alignment: Alignment.center,
        child: Container(
          child: Text(
              'No Results',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  fontFamily: _font,
                  fontWeight: FontWeight.w700,
                  fontSize: 40.0)
          ),
        ),
      )];
    }
  }

  ///Constructor
  _HomePage(this._font);

  ///Returns list of shelves to display after updates in FutureBuilder.
  Future<List<Widget>> getListedShelves() async{
    return listedShelves;
  }

  ///Returns water level to display on home page.
  double getWaterBaseLevel() {
    SensorPostGet sensorData = sensorPostFromJson('1');
    return sensorData.readings.last.baseLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: titleText,
            // search button should go here
          )
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.green,
            height: 100,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.help, color: Colors.white),
                  title: const Text(
                    "Grow Guide",
                    style: TextStyle(
                      height: 2,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color: Colors.white
                    ),
                  ),
                  onTap: () {
                    print("tapped grow guide");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.ios_share, color: Colors.white),
                  title: const Text(
                    "Share",
                    style: TextStyle(
                      height: 2,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color: Colors.white
                    ),
                  ),
                  onTap: () {
                    print("tapped share");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        // appBar: PreferredSize(
        //     ///Modifies height of AppBar
        //     preferredSize: Size.fromHeight(70.0),
        //     child: AppBar(
        //         title: titleText,
        //         actions: [
        //           ///Search button
        //           Padding(
        //               padding: EdgeInsets.only(top: 12.0),
        //               child: IconButton(
        //                   icon: searchOrCancelIcon,
        //                   iconSize: 35.0,
        //                   splashColor: Colors.transparent,
        //                   onPressed: () {
        //                     ///Open search entry box
        //                     setState(() {
        //                       if (searchOrCancelIcon.icon == Icons.search) {
        //                         ///Display text box for user's search input
        //                         searchOrCancelIcon = const Icon(Icons.cancel);
        //                         titleText = ListTile(
        //                           contentPadding: EdgeInsets.only(left: 0.0, top: 5.0),
        //                           leading: Padding(
        //                             padding: EdgeInsets.only(top: 12.0),
        //                             child: Icon (
        //                               Icons.search,
        //                               color: Colors.white,
        //                               size: 35.0,
        //                             )
        //                           ),
        //                           title: TextField(
        //                             decoration: InputDecoration(
        //                               hintText: 'Type in a shelf or plant...',
        //                               hintStyle: TextStyle(
        //                                 color: Colors.white,
        //                                 height: 2,
        //                                 fontSize: 18.0,
        //                                 fontStyle: FontStyle.italic,
        //                               ),
        //                               border: InputBorder.none,
        //                             ),
        //                             style: TextStyle(
        //                               color: Colors.white,
        //                             ),
        //                             onSubmitted: (String searchText) {
        //                               ///Update listed shelves once user submits search entry
        //                               setState(() {
        //                                 ///Remove whitespace before sending search.
        //                                 updateListedShelves(searchText.replaceAll(' ', ''));
        //                               });
        //                             }
        //                           ),
        //                         );
        //                       }
        //                       else {
        //                         ///Reset to search button and default title
        //                         searchOrCancelIcon = const Icon(Icons.search);
        //                         titleText = Text(
        //                             'ZotPonics',
        //                             style: TextStyle(
        //                                 height: 2,
        //                                 fontFamily: _font,
        //                                 fontWeight: FontWeight.w700,
        //                                 fontSize: 40.0,
        //                                 color: Colors.white)
        //                         );
        //                         setState(() {
        //                           updateListedShelves('');
        //                         });
        //                       }
        //                     });
        //                   }
        //               )
        //           ),
        //           ///Guide button
        //           Padding(
        //               padding: EdgeInsets.only(top: 12.0),
        //               child: IconButton(
        //                   icon: Icon(Icons.help, color: Colors.white),
        //                   iconSize: 35.0,
        //                   splashColor: Colors.transparent,
        //                   onPressed: () {
        //                     ///Go to growing guide
        //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => GrowGuide(_font)));
        //                   }
        //               )
        //           )
        //         ]
        //     )
        // ),
        ///Info cards
        body: FutureBuilder<List<Widget>>(
            future: getListedShelves(), ///Activates every time state changes
            builder: (context, snapshot) {
                try { /// Display reservoir water level if possible
                  List<Widget> shelvesWithWaterLevel = [TextWidget('Reservoir Water Level: ${getWaterBaseLevel()} cm', _font, Colors.black, FontWeight.w400, 15)];
                  shelvesWithWaterLevel.addAll(snapshot.data);
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: shelvesWithWaterLevel
                    );
                }
                catch (e) { /// Display just the shelves if the water level can't be identified
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data
                  );
                }
            }
        )
        /*bottomNavigationBar: new BottomAppBar( /// create and delete buttons
            child: Row(
                children: <Widget>[
                  Expanded(
                      child: FlatButton(
                          color: Colors.white,
                          child: TextWidget("Demo", _font, Colors.green, FontWeight.w400, 15.0),
                          onPressed: () {
                            ///Go to demo page
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DemoPage(_font)));
                          }
                      )
                  )
                ]
            )
        )*/
    );
  }
}
