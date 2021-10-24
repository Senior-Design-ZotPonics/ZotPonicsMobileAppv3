import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/tempSeries.dart';

class TemperatureChart extends StatelessWidget {
  final List<TempSeries> temperatureData;

  TemperatureChart({@required this.temperatureData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TempSeries, String>> series = [
      charts.Series(
          id: "temperatures",
          data: temperatureData,
          domainFn: (TempSeries series, _) => series.day,
          measureFn: (TempSeries series, _) => series.temp,
          colorFn: (TempSeries series, _) => series.barColor
      )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                "Temperature Sensor Data",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,
                )
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}