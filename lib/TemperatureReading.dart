import 'dart:convert';
TemperatureReading trFromJson(String str) => TemperatureReading.fromJson(json.decode(str));
String trToJson(TemperatureReading data) => json.encode(data.toJson());

class TemperatureReading {
  double temperature;
  DateTime timestamp;

  TemperatureReading({
    this.temperature,
    this.timestamp,
  });

  factory TemperatureReading.fromJson(Map<String, dynamic> json) => TemperatureReading(
      temperature: json["temperature"],
      timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature,
    "timestamp": timestamp
  };
}