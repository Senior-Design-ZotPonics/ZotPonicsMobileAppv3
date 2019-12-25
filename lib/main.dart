import 'package:flutter/material.dart';
import 'homePage.dart';

///Guide to JSON: https://stackoverflow.com/questions/51061412/how-to-set-the-text-value-dynamically-from-the-json-in-flutter

void main() => runApp(ZotPonics());

class ZotPonics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZotPonics',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        ///Colors AppBar and other general things
        primarySwatch: Colors.green
      ),
      home: HomePage('Montserrat')
    );
  }
}
