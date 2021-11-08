import 'dart:convert';
HumidityReading trFromJson(String str) => HumidityReading.fromJson(json.decode(str));
String trJson(HumidityReading data) => json.encode(data.toJson());

class HumidityReading {
  double humidity;
  DateTime timestamp;

  HumidityReading({
    this.humidity,
    this.timestamp
  });

  factory HumidityReading.fromJson(Map<String, dynamic> json) => HumidityReading(
    humidity: json["humidity"],
    timestamp: DateTime.parse(json["timestamp"])
  );

  Map<String, dynamic> toJson() => {
    "humidity": humidity,
    "timestamp": timestamp
  };
}