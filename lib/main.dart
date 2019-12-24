import 'package:flutter/material.dart';
import 'homePage.dart';

///https://stackoverflow.com/questions/51061412/how-to-set-the-text-value-dynamically-from-the-json-in-flutter

void main() => runApp(ZotPonics());

class ZotPonics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZotPonics',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Montserrat',
        primarySwatch: Colors.green,
      ),
      home: HomePage('Montserrat'),
    );
  }
}
