import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ZotPonics",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900, fontSize: 40)
            ),
            Text(
              "A Sustainable Hydroponic System",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green.shade900, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  //margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 50.0, bottom: 50.0, right: 10.0),
                    child: Column(
                      children: [
                        Text(
                            "My Top Plant",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)
                        ),
                        Text(
                            _topPlant,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.green.shade900)
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0, left: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 50.0, left: 30.0, right: 30.0),
                    child: Column(
                      children: [
                        Text("Average\nHumidity",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)
                        ),
                        Text(_averageHumidity.toString() + "%",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.green.shade800)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade300,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 60.0, bottom: 60.0, right: 10.0),
                    child: Column(
                      children: [
                        Text("Average\nTemperature",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                        ),
                        Text(_averageTemperature.toString() + "\u00B0C",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.green.shade700)
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0, bottom: 50.0),
                    child: Column(
                      children: [
                        Text("Number of\nPlants Grown",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)
                        ),
                        Text(_numberOfPlants.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.green.shade900)
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ],
        )
    );
  }
}