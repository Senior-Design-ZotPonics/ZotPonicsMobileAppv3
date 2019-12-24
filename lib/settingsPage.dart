import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'textWidget.dart';
import 'settingItems.dart';

class SettingsPage extends StatelessWidget {
  final String _font;

  SettingsPage(this._font);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            iconSize: 35.0,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.of(context).pop(), ///Go back to home page
          ),
          title: TextWidget(
              'Settings',
              _font,
              Colors.white,
              FontWeight.w600,
              35.0),
        ),
        body: ListView(
            children: <Widget>[
                SettingItem('Number', 'Max Temperature', '100°F', FontAwesomeIcons.thermometerFull, _font)
        ]));
  }
}
