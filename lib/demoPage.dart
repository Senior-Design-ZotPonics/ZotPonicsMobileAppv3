import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'demoCard.dart';

///Demo page of the app

class DemoPage extends StatelessWidget {
  final String _font;

  ///Constructor
  DemoPage(this._font);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
            ///Modifies height of AppBar
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
                title: Text(
                    'ZotPonics Demo',
                    style: TextStyle(
                        height: 2,
                        fontFamily: _font,
                        fontWeight: FontWeight.w700,
                        fontSize: 40.0,
                        color: Colors.white)
                )
            )
        ),
        ///Info cards
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DemoCard('Fans', Colors.cyan, FontAwesomeIcons.fan),
              DemoCard('Lights', Colors.yellow, FontAwesomeIcons.lightbulb),
              DemoCard('Pumps', Colors.blue, FontAwesomeIcons.tint),
              DemoCard('Vents', Colors.orange, FontAwesomeIcons.doorOpen)
            ]
        )
    );
  }
}
