/*
Defines model for humidity data
 */

class HumiditySeries {
  final double humidity;
  final DateTime timestamp;

  HumiditySeries (
    this.humidity,
    this.timestamp
  );
}