import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/humiditySeries.dart';

/*
Builds and formats humidity bar chart widget
 */

class HumidityChart extends StatelessWidget {
  final List<HumiditySeries> humidityData;

  HumidityChart({@required this.humidityData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HumiditySeries, String>> series = [
      charts.Series(
        id: "humidity values",
        data: humidityData,
        domainFn: (HumiditySeries series, _) => series.timestamp.month.toString() +
          '/' + series.timestamp.day.toString(),
        measureFn: (HumiditySeries series, _) => series.humidity,
        colorFn: (HumiditySeries series, _) => charts.ColorUtil.fromDartColor(Colors.cyan)
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

            new charts.ChartTitle('Humidity %',
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