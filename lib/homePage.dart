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

  @override
  void initState() {
    super.initState();
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
                title: Text(
                    'ZotPonics',
                    style: TextStyle(
                        height: 2,
                        fontFamily: _font,
                        fontWeight: FontWeight.w700,
                        fontSize: 40.0,
                        color: Colors.white)
                ),
                actions: [
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
        body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShelfButton('Shelf 1', Colors.amberAccent, FontAwesomeIcons.solidSun, _font, 1),
                      ShelfButton('Shelf 2', Colors.lightGreen, FontAwesomeIcons.seedling, _font, 2),
                      ShelfButton('Shelf 3', Colors.lightBlue, FontAwesomeIcons.water, _font, 3)
                    ]
                )
    );
  }
}
