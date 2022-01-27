import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'homePage.dart';
import 'demoPage.dart';
import 'getTest.dart';
import 'tempStatistics.dart';
import 'widgetsForTesting/temperatureDataTest.dart';
import 'socialMediaWidget.dart';


///Guide to JSON: https://stackoverflow.com/questions/51061412/how-to-set-the-text-value-dynamically-from-the-json-in-flutter

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(ZotPonics());
}

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
        // home: DemoPage('Montserrat')
        // home: DataTest(1) -- used to test temperature data from database
        // home: TempStatistics() -- used to test bar chart
        // home: GetTest() -- used to test http request
        // home: SocialMediaWidget('Montserrat', 'tomato', 12, 26.0, 85.0) -- used to teset social media widget
    );
  }
}
