import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homePage.dart';
import 'demoPage.dart';

///Guide to JSON: https://stackoverflow.com/questions/51061412/how-to-set-the-text-value-dynamically-from-the-json-in-flutter

void main() => runApp(ZotPonics());

class ZotPonics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'ZotPonics',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        ///Colors AppBar and other general things
        primarySwatch: Colors.green
      ),
      home: HomePage('Montserrat')
      //home: DemoPage('Montserrat')
    );
  }
}
