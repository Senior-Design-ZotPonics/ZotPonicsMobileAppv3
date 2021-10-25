import 'package:flutter/material.dart';
import 'package:flutter_app/demoPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'infoCard.dart';
import 'settingsPage.dart';
import 'services.dart';
import 'textWidget.dart';
import 'demoPage.dart';

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

  @override
  void initState() {
    super.initState();
    ///Fetch data every five minutes
    timer = Timer.periodic(Duration(minutes: 5), (Timer t) => setState(() {}));
  }

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
                      InfoCard('${snapshot.data.readings.last.temperature}°C', 'Temperature', Colors.red, FontAwesomeIcons.thermometerHalf, shelfNum),
                      InfoCard('${snapshot.data.readings.last.humidity}%', 'Humidity', Colors.cyan, FontAwesomeIcons.tint, shelfNum),
                      snapshot.data.readings.last.lightStatus.toLowerCase() == 'true' ? InfoCard('ON', 'Lights', Colors.yellow, FontAwesomeIcons.lightbulb, shelfNum) : InfoCard('OFF', 'Lights', Colors.grey, FontAwesomeIcons.lightbulb, shelfNum),
                      InfoCard('${_formattedTime(snapshot.data.readings.last.lastWateredTimestamp, false)}', 'Last Watered [${_formattedDate(snapshot.data.readings.last.lastWateredTimestamp)}]', Colors.indigo, FontAwesomeIcons.clock, shelfNum),
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
