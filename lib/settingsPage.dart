import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'textWidget.dart';
import 'settingItem.dart';
import 'timeSettingItem.dart';
import 'saveProfileButton.dart';
import 'services.dart';
import 'inputDialog.dart';
import 'package:intl/intl.dart';
import 'demoPage.dart';

///Settings page

class SettingsPage extends StatefulWidget {
  final String _font;

  ///Constructor
  SettingsPage(this._font);

  @override
  State<StatefulWidget> createState() => _SettingsPage(_font);
}


class _SettingsPage extends State<SettingsPage> {
  final String _font;

  ///Controller objects to read SettingItem inputs
  final maxTemp = TextEditingController();
  final maxHumid = TextEditingController();
  final lightStart = TextEditingController();
  final lightEnd = TextEditingController();
  final duration = TextEditingController();
  final frequency = TextEditingController();
  final nutrientRatio = TextEditingController();
  final baseLevel = TextEditingController();
  final profileName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  ///Required method to dispose of controllers
  @override
  void dispose() {
    maxTemp.dispose();
    maxHumid.dispose();
    lightStart.dispose();
    lightEnd.dispose();
    duration.dispose();
    frequency.dispose();
    nutrientRatio.dispose();
    baseLevel.dispose();
    profileName.dispose();
    super.dispose();
  }

  ///Constructor
  _SettingsPage(this._font);

  ///Post setting values to database
  bool postSettings() {
    CGPostPut post = CGPostPut(
        writings: [ CGWriting(
            timestamp: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            lightStart: int.parse(lightStart.text),
            lightEnd: int.parse(lightEnd.text),
            humidity: int.parse(maxHumid.text),
            temp: int.parse(maxTemp.text),
            waterFreq: int.parse(frequency.text),
            waterDuration: int.parse(duration.text),
            nutrientRatio: int.parse(nutrientRatio.text),
            baseLevel: int.parse(baseLevel.text)
        )]
    );

    postControlGrowth(post).then((response) {
      if(response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
      return false;
    });

    return true;
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
                    'Settings',
                    style: TextStyle(
                        height: 1.8,
                        fontFamily: _font,
                        fontWeight: FontWeight.w600,
                        fontSize: 36.0,
                        color: Colors.white
                    )
                ),
                ///Drop down menu to access demo mode or load profile
                actions: [
                  PopupMenuButton<String>(
                    padding: EdgeInsets.only(top: 12.0, right: 3.0),
                    offset: Offset.fromDirection(pi/2, 70.0),
                    icon: Icon(Icons.more_vert, color: Colors.white, size: 30),
                    onSelected: (value) {
                      if (value == "Demo") {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DemoPage(_font)));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: 'Demo',
                        child: Text('Demo Mode')
                      ),
                      PopupMenuItem<String>(
                          value: 'Profile',
                          child: Text('Load Profile')
                      ),
                    ],
                  )
                ]
            )
        ),
        ///Setting items
        body: FutureBuilder<CGPostGet>(
            future: getControlGrowth(), ///Activates every time state changes
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: TextWidget('ERROR', _font, Colors.red, FontWeight.w400, 40.0));
                }

                ///Sets initial values of controllers to database values
                maxTemp.text = snapshot.data.readings.last.temperature.toInt().toString();
                maxHumid.text = snapshot.data.readings.last.humidity.toInt().toString();
                lightStart.text = snapshot.data.readings.last.lightStart.toInt().toString();
                lightEnd.text = snapshot.data.readings.last.lightEnd.toInt().toString();
                duration.text = snapshot.data.readings.last.waterDuration.toInt().toString();
                frequency.text = snapshot.data.readings.last.waterFreq.toInt().toString();
                nutrientRatio.text = snapshot.data.readings.last.nutrientRatio.toInt().toString();
                baseLevel.text = snapshot.data.readings.last.baseLevel.toInt().toString();

                return ListView(children: [
                  SettingItem('Max Temperature', maxTemp, FontAwesomeIcons.thermometerFull, _font, suffix: '°C'),
                  SettingItem('Max Humidity', maxHumid, FontAwesomeIcons.water, _font, suffix: '%'),
                  TimeSettingItem('Light Start Time', lightStart, FontAwesomeIcons.clock, _font),
                  TimeSettingItem('Light End Time', lightEnd, FontAwesomeIcons.solidClock, _font),
                  SettingItem('Watering Duration', duration, FontAwesomeIcons.tint, _font, suffix: ' seconds'),
                  SettingItem('Watering Frequency', frequency, FontAwesomeIcons.stopwatch, _font, prefix: 'Every ', suffix: ' seconds'),
                  SettingItem('Nutrient Ratio', nutrientRatio, FontAwesomeIcons.percentage, _font, suffix: '%')
                ]);
              }
              else {
                return Center(child: TextWidget('Loading...', _font, Colors.black, FontWeight.w400, 20.0));
                ///In case you may need to connect to a local server (would have to modify services.dart as well)
                //return SettingItem('IP Address', ipAddr, FontAwesomeIcons.networkWired, _font, numInput: false);
              }
            }
        ),
        ///Save profile button
        floatingActionButton: Builder( ///Builder required to create a context so that snack bar can be shown
            builder: (context) => FloatingActionButton.extended(
                label: TextWidget(
                    'Save',
                    _font,
                    Colors.white,
                    FontWeight.w600,
                    20.0
                ),
                onPressed: () {
                  if (postSettings()) { ///Returns true if settings successfully posted
                    Scaffold.of(context).showSnackBar(
                        ///Popup confirmation bar
                        SnackBar(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))
                            ),
                            duration: Duration(seconds: 1, milliseconds: 500),
                            content: Text('Settings successfully saved!')
                        )
                    );
                  }
                }
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
    );
  }
}
