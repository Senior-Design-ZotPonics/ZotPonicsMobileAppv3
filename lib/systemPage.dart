import 'package:flutter/material.dart';
import 'package:flutter_app/demoPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'infoCard.dart';
import 'settingsPage.dart';
import 'services.dart';
import 'textWidget.dart';
import 'demoPage.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
///For more information on how to work with notifications, check these out:
/// - https://pub.dev/packages/flutter_local_notifications#-readme-tab-
/// - https://www.youtube.com/watch?v=xMeCwF5MO6w


///Main page of the app

class SystemPage extends StatefulWidget {
  final String _font;
  final int shelfNum;

  ///Constructor
  SystemPage(this._font, this.shelfNum);

  @override
  State<StatefulWidget> createState() => _SystemPage(_font, shelfNum);
}


class _SystemPage extends State<SystemPage> {
  final String _font;
  final int shelfNum;
  Timer timer;

  ///Plugin to handle notifications
  FlutterLocalNotificationsPlugin notifPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    ///Fetch data every five minutes
    timer = Timer.periodic(Duration(minutes: 5), (Timer t) => setState(() {}));

    ///Initializing settings for notifications
    final androidSettings = AndroidInitializationSettings('notif_icon');
    final iOSSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => notificationSelected(payload));

    notifPlugin.initialize( InitializationSettings(androidSettings, iOSSettings), onSelectNotification: notificationSelected);

    displayReminderNotifPeriodically();
  }

  ///When notification is tapped, this function is run
  Future notificationSelected(String payload) async => await Navigator.push(
    context, MaterialPageRoute(builder: (context) => SettingsPage(_font, shelfNum))
  );

  ///Constructor
  _SystemPage(this._font, this.shelfNum);

  ///Convert DateTime object to date string
  String _formattedDate(DateTime input) {
    return '${input.month}/${input.day}/${input.year}';
  }

  ///Convert DateTime object to time string
  String _formattedTime(DateTime input, bool includeSeconds) {
    String hour = (input.hour < 10) ? '0${input.hour}' : '${input.hour}';
    String minute = (input.minute < 10) ? '0${input.minute}' : '${input.minute}';
    String second = (input.second < 10) ? '0${input.second}' : '${input.second}';
    return (includeSeconds) ? '$hour:$minute:$second' : '$hour:$minute';
  }

  ///Displays reminder notifications
  Future displayReminderNotifPeriodically() {
    ///Notification setup
    var time = Time(20, 0, 0); ///8:00 PM
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Channel ID', 'ZotPonics', 'Channel Description',
        importance: Importance.Default, priority: Priority.Default, ticker: 'Replace your nutrient water!');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    ///Notification appears weekly Sunday at 12:00
    ///We should have biweekly notifications, but that would require modifying the package source code
    ///Needs more discussion
    notifPlugin.showWeeklyAtDayAndTime(
        0, 'ZotPonics Reminder', 'Replace your nutrient water!', Day.Saturday, time, RepeatInterval.Biweekly, platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
            ///Modifies height of AppBar
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
                ///Back button
                leading: IconButton(
                    padding: EdgeInsets.only(top: 12.0),
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                    iconSize: 35.0,
                    splashColor: Colors.transparent,
                    ///Go back to home page
                    onPressed: () => Navigator.of(context).pop()
                ),
                title: Text(
                    'Shelf ' + this.shelfNum.toString(),
                    style: TextStyle(
                        height: 2,
                        fontFamily: _font,
                        fontWeight: FontWeight.w700,
                        fontSize: 40.0,
                        color: Colors.white)
                ),
                actions: [
                  ///Settings button
                  Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: IconButton(
                        icon: Icon(Icons.settings, color: Colors.white),
                        iconSize: 35.0,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          ///Go to settings page
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage(_font, shelfNum)));
                        }
                      )
                  )
                ]
            )
        ),
        ///Info cards
        body: FutureBuilder<SensorPostGet>(
            future: getSensorData(shelfNum), ///Activates every time state changes
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: TextWidget('ERROR', _font, Colors.red, FontWeight.w400, 40.0));
                }
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoCard('${snapshot.data.readings.last.temperature}°C', 'Temperature', Colors.red, FontAwesomeIcons.thermometerHalf),
                      InfoCard('${snapshot.data.readings.last.humidity}%', 'Humidity', Colors.cyan, FontAwesomeIcons.tint),
                      snapshot.data.readings.last.lightStatus.toLowerCase() == 'true' ? InfoCard('ON', 'Lights', Colors.yellow, FontAwesomeIcons.lightbulb) : InfoCard('OFF', 'Lights', Colors.grey, FontAwesomeIcons.lightbulb),
                      InfoCard('${snapshot.data.readings.last.baseLevel}', 'Base Level', Colors.brown, FontAwesomeIcons.windowMaximize),
                      InfoCard('${_formattedTime(snapshot.data.readings.last.lastWateredTimestamp, false)}', 'Last Watered [${_formattedDate(snapshot.data.readings.last.lastWateredTimestamp)}]', Colors.indigo, FontAwesomeIcons.clock),
                      ///Update and check info
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                                'Last updated: ${_formattedTime(snapshot.data.readings.last.timestamp, true)}, ${_formattedDate(snapshot.data.readings.last.timestamp)}  |  Last checked: ${_formattedTime(DateTime.now(), true)}, ${_formattedDate(DateTime.now())}',
                                _font,
                                Colors.black,
                                FontWeight.w400,
                                10.0
                            )
                          ]
                      )
                    ]
                );
              }
              else {
                return Center(child: TextWidget('Loading...', _font, Colors.black, FontWeight.w400, 20.0));
              }
            }
        )
    );
  }
}
