import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

// creates model for temperature data
class TempSeries {
  final double temp;
  final DateTime timestamp; // update this to DateTime for real data
  // final charts.Color barColor;

  TempSeries(
    {
      @required this.temp,
      @required this.timestamp
      // @required this.barColor
    }
  );
}