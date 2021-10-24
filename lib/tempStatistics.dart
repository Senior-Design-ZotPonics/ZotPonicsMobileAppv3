import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/tempBarChart.dart';
import 'package:flutter_app/tempSeries.dart';

class TempStatistics extends StatelessWidget {
  // hardcoded temperature data -- update to retrieve data from database
  final List<TempSeries> temperatureData = [
    TempSeries(temp: 22.0, day: "0", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 21.2, day: "3", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 21.4, day: "2", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 19.9, day: "7", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    TempSeries(temp: 24.7, day: "10", barColor: charts.ColorUtil.fromDartColor(Colors.red)),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: TemperatureChart(temperatureData: temperatureData),
      ),
    );
  }
}