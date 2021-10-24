import 'package:flutter/material.dart';
import 'package:flutter_app/demoPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'shelfButton.dart';
import 'systemPage.dart';
import 'services.dart';
import 'textWidget.dart';
import 'demoPage.dart';
import 'growGuide.dart';

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
  List<Widget> listedShelves = [];

  @override
  void initState() {
    super.initState();

    ///Initializing settings for notifications
    final androidSettings = AndroidInitializationSettings('notif_icon');
    final iOSSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => notificationSelected(payload));

    notifPlugin.initialize(InitializationSettings(androidSettings, iOSSettings), onSelectNotification: notificationSelected);

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

  ///Updates list of shelves to display based on user's inputted search
  void updateListedShelves(searchText) {
    ShelfButton shelf1 = ShelfButton('Shelf 1', Colors.amberAccent, FontAwesomeIcons.solidSun, _font, 1);
    ShelfButton shelf2 = ShelfButton('Shelf 2', Colors.lightGreen, FontAwesomeIcons.seedling, _font, 2);
    ShelfButton shelf3 = ShelfButton('Shelf 3', Colors.lightBlue, FontAwesomeIcons.water, _font, 3);
    switch (searchText) {
      case '1': { listedShelves = [shelf1]; }
        break;
      case '2': { listedShelves = [shelf2]; }
        break;
      case '3': { listedShelves = [shelf3]; }
        break;
      case '': { listedShelves = [shelf1, shelf2, shelf3]; }
      break;
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
      break;
    }
    print(listedShelves);
  }

  ///Constructor
  _HomePage(this._font);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
            ///Modifies height of AppBar
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
                title: titleText,
                actions: [
                  ///Search button
                  Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: IconButton(
                          icon: searchOrCancelIcon,
                          iconSize: 35.0,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            ///Open search entry box
                            setState(() {
                              if (searchOrCancelIcon.icon == Icons.search) {
                                ///Display text box for user's search input
                                searchOrCancelIcon = const Icon(Icons.cancel);
                                titleText = ListTile(
                                  contentPadding: EdgeInsets.only(left: 0.0, top: 5.0),
                                  leading: Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Icon (
                                      Icons.search,
                                      color: Colors.white,
                                      size: 35.0,
                                    )
                                  ),
                                  title: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Type in a shelf or plant...',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                        height: 2,
                                        fontSize: 18.0,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    onSubmitted: (String searchText) {
                                      ///Update listed shelves once user submits search entry
                                      setState(() {
                                        updateListedShelves(searchText.replaceAll(' ', ''));
                                      });
                                    }
                                  ),
                                );
                              }
                              else {
                                ///Reset to search button and default title
                                searchOrCancelIcon = const Icon(Icons.search);
                                titleText = Text(
                                    'ZotPonics',
                                    style: TextStyle(
                                        height: 2,
                                        fontFamily: _font,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 40.0,
                                        color: Colors.white)
                                );
                                setState(() {
                                  updateListedShelves('');
                                });
                              }
                            });
                          }
                      )
                  ),
                  ///Guide button
                  Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: IconButton(
                          icon: Icon(Icons.help, color: Colors.white),
                          iconSize: 35.0,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            ///Go to growing guide
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GrowGuide(_font)));
                          }
                      )
                  )
                ]
            )
        ),
        ///Info cards
        body: FutureBuilder<SensorPostGet>(
            future: getSensorData(1), ///Activates every time state changes
            builder: (context, snapshot) {
              List<Widget> shelves = listedShelves;
                try { /// Display reservoir water level if possible
                  List<Widget> shelvesWithWaterLevel = [TextWidget('Reservoir Water Level: ${snapshot.data.readings.last.baseLevel} cm', _font, Colors.black, FontWeight.w400, 15)];
                  shelves.addAll(shelves);
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
                        children: shelves
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
