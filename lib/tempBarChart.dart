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
          domainFn: (TempSeries series, _) => series.timestamp.month.toString() +
              '/' + series.timestamp.day.toString(),
          measureFn: (TempSeries series, _) => series.temp,
          colorFn: (TempSeries series, _) => charts.ColorUtil.fromDartColor(Colors.red)
      )
    ];

    return Container(
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: charts.BarChart(
          series,
          animate: true,
          behaviors: [
            // new charts.ChartTitle('Monthly Temperature Data',
            //   behaviorPosition: charts.BehaviorPosition.top,
            //   titleOutsideJustification: charts.OutsideJustification.start,
            //   innerPadding: 18,
            //   titleStyleSpec: charts.TextStyleSpec(
            //     color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
            //     fontFamily: 'Montserrat',
            //     fontSize: 20,
            //     fontWeight: 'bold'
            //   ),
            // ),
            new charts.SlidingViewport(),
            new charts.PanAndZoomBehavior(),

            new charts.ChartTitle('Date',
              behaviorPosition: charts.BehaviorPosition.bottom,
              titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
              titleStyleSpec: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: 'bold',
              ),
            ),

            new charts.ChartTitle('Temperature °C',
              behaviorPosition: charts.BehaviorPosition.start,
              titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
              titleStyleSpec: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: 'bold',
              ),
            ),
          ],
          domainAxis: new charts.OrdinalAxisSpec(
            viewport: new charts.OrdinalViewport('AePS', 8),
          ),
        ),
      ),
    );
  }
}