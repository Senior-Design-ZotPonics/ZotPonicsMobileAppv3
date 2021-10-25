import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/tempBarChart.dart';
import 'package:flutter_app/tempSeries.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'textWidget.dart';

class TempStatistics extends StatefulWidget {

  final int shelfNum;

  TempStatistics(this.shelfNum);

  @override
  State<StatefulWidget> createState() => _TempStatistics(this.shelfNum);

}

class _TempStatistics extends State<TempStatistics> {

  final int shelfNum;

  @override
  void initState() => super.initState();

  _TempStatistics(this.shelfNum);

  // hardcoded temperature data -- update to retrieve data from database
  final List<TempSeries> temperatureData = [
    TempSeries(temp: 22.0, day: "0", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 21.2, day: "3", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 21.4, day: "2", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 19.9, day: "7", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 24.7, day: "10", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
  ];

  @override
  double getAverage(List<TempSeries> temperatureData) {
    double temperatureAverage;
    double totalTemperature = 0.0;
    int numReadings = temperatureData.length;
    for (var i=0; i<numReadings; i++){
      totalTemperature += temperatureData[i].temp;
    }
    temperatureAverage = totalTemperature/numReadings;
    return temperatureAverage;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: PreferredSize(
        ///Modifies height of AppBar
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            ///Back button
              backgroundColor: Colors.red,
              leading: IconButton(
                  padding: EdgeInsets.only(top: 12.0),
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                  iconSize: 35.0,
                  splashColor: Colors.transparent,
                  ///Go back to home page
                  onPressed: () => Navigator.of(context).pop()
              ),
              title: Text(
                  'Temperature - Shelf ' + this.shelfNum.toString(),
                  style: TextStyle(
                      height: 2,
                      // fontFamily: _font,
                      fontWeight: FontWeight.w500,
                      fontSize: 23.0,
                      color: Colors.white)
              ),
          )
      ),
      body:
          Container(
            height: 700,
            // padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(getAverage(temperatureData).toString(), FontAwesomeIcons.atlassian.toString(), Colors.red, FontWeight.w700, 45.0)
                  )
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TemperatureChart(temperatureData: temperatureData)
                  ),
                ),
              ],
            ),
          ),
    );
  }
}