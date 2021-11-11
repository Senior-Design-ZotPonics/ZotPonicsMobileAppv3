import 'package:flutter/foundation.dart';

/*
creates model for temperature data
 */

class TempSeries {
  final double temp;
  final DateTime timestamp;

  TempSeries(
    {
      @required this.temp,
      @required this.timestamp
    }
  );
}