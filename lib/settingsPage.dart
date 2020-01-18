import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'textWidget.dart';
import 'settingItem.dart';
import 'timeSettingItem.dart';
import 'saveProfileButton.dart';
import 'services.dart';

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
  int maxTemp;
  int maxHumid;
  int lightStart;
  int lightEnd;
  int duration;
  int frequency;
  SettingItem s;

  @override
  void initState() {
    super.initState();
  }

  ///Constructor
  _SettingsPage(this._font);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
            ///Back button
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                iconSize: 35.0,
                splashColor: Colors.transparent,
                ///Go back to home page
                onPressed: () => Navigator.of(context).pop()
            ),
            title: TextWidget(
                'Settings',
                _font,
                Colors.white,
                FontWeight.w600,
                35.0
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
                maxTemp = snapshot.data.readings.last.temperature.toInt();
                maxHumid = snapshot.data.readings.last.humidity.toInt();
                lightStart = snapshot.data.readings.last.lightStart.toInt();
                lightEnd = snapshot.data.readings.last.lightEnd.toInt();
                duration = snapshot.data.readings.last.waterDuration.toInt();
                frequency = snapshot.data.readings.last.waterFreq.toInt();
                ///Key to getting values back to POST to database
                s = SettingItem('Max Temperature', maxTemp, FontAwesomeIcons.thermometerFull, _font, suffix: '°C');
                return ListView(children: [
                  s,
                  SettingItem('Max Humidity', maxHumid, FontAwesomeIcons.water, _font, suffix: '%'),
                  TimeSettingItem('Light Schedule', lightStart, lightEnd, FontAwesomeIcons.clock, _font),
                  SettingItem('Watering Duration', duration, FontAwesomeIcons.tint, _font, suffix: ' mins'),
                  SettingItem('Watering Frequency', frequency, FontAwesomeIcons.stopwatch, _font, prefix: 'Every ', suffix: ' mins')
                ]);
              }
              else {
                return Center(child: TextWidget('Loading...', _font, Colors.black, FontWeight.w400, 20.0));
              }
            }
        ),
        ///Save profile button
        floatingActionButton: SaveProfileButton(_font),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
    );
  }
}
