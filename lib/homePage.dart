import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'infoCard.dart';
import 'settingsPage.dart';

class HomePage extends StatelessWidget {
  final String _font;

  HomePage(this._font);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), ///Modifies height of AppBar
          child: AppBar(
            title: Text('ZotPonics',
                style: TextStyle(
                    height: 2,
                    fontFamily: _font,
                    fontWeight: FontWeight.w700,
                    fontSize: 40.0,
                    color: Colors.white)),
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage(_font)));
                    },
                  ))
            ],
          ),
        ),
        ///Info cards
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoCard('75°F', 'Temperature', Colors.red, FontAwesomeIcons.thermometerHalf),
              InfoCard('60%', 'Humidity', Colors.orange, FontAwesomeIcons.water),
              InfoCard('ON', 'Lights', Colors.yellow, FontAwesomeIcons.lightbulb),
              InfoCard('6.2 cm', 'Plant Height', Colors.lightGreen, FontAwesomeIcons.leaf),
              InfoCard('17:00', 'Last Watered', Colors.lightBlue, FontAwesomeIcons.clock)
            ]));
  }
}
