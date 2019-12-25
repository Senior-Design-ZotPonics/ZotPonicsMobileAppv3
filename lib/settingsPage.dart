import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'textWidget.dart';
import 'settingItem.dart';
import 'timeSettingItem.dart';
import 'saveProfileButton.dart';

///Settings page

class SettingsPage extends StatelessWidget {
  final String _font;

  ///Constructor
  SettingsPage(this._font);

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
        body: ListView(children: [
            SettingItem('Max Temperature', FontAwesomeIcons.thermometerFull, _font, suffix: '°F'),
            SettingItem('Max Humidity', FontAwesomeIcons.water, _font, suffix: '%'),
            TimeSettingItem('Light Schedule', FontAwesomeIcons.clock, _font),
            SettingItem('Watering Duration', FontAwesomeIcons.tint, _font, suffix: ' mins'),
            SettingItem('Watering Frequency', FontAwesomeIcons.stopwatch, _font, prefix: 'Every ', suffix: ' mins')
        ]),
        ///Save profile button
        floatingActionButton: SaveProfileButton(_font),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
    );
  }
}
