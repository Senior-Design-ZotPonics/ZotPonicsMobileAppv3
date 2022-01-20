import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';
import 'hydroponicsOverview.dart';
import 'gettingStarted.dart';
import 'hydroponicGardening.dart';
import 'systemMaintenance.dart';

///Currently only has hard-coded profiles
///If we were to allow users to add their own profiles or load from the database,
///this would require a bit more work

///Guide page with various topics for beginners

class SocialMediaWidget extends StatefulWidget {
  final String _font;
  final String _topPlant;
  final int _numberOfPlants;
  final double _averageTemperature;
  final double _averageHumidity;

  ///Constructor
  SocialMediaWidget(this._font, this._topPlant, this._numberOfPlants, this._averageTemperature, this._averageHumidity);

  @override
  State<StatefulWidget> createState() => _SocialMediaWidget(_font, _topPlant, _numberOfPlants, _averageTemperature, _averageHumidity);
}


class _SocialMediaWidget extends State<SocialMediaWidget> {
  final String _font;
  final String _topPlant;
  final int _numberOfPlants;
  final double _averageTemperature;
  final double _averageHumidity;

  ///Constructor
  _SocialMediaWidget(this._font, this._topPlant, this._numberOfPlants, this._averageTemperature, this._averageHumidity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade100,
        body: Column(
          children: [
            Text(
              "\n\nZotPonics",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900, fontSize: 40)
            ),
            Text(
              "A Sustainable Hydroponic System",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green.shade900, fontSize: 20),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 70.0, bottom: 70.0, right: 35.0),
                    child: Text(
                      "My Top Plant\n" + "_topPlant",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 80.0, left: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 60.0, left: 30.0, right: 30.0),
                    child: Text("Avg Humidity\n" + "###", textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade300,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 55.0, bottom: 55.0, right: 15.0),
                    child: Text("Avg Temperature\n" + "###", textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 80.0, bottom: 80.0),
                    child: Text("Number of Plants Grown\n" + "###", textAlign: TextAlign.center,),
                  ),
                ),
              ]
            ),
          ],
        )
    );
  }
}