import 'dart:convert';

import 'package:flutter/cupertino.dart';
PlantReading trFromJson(String str) => PlantReading.fromJson(json.decode(str));
String trToJson(PlantReading data) => json.encode(data.toJson());

/*
Defines logic to parse the temperature data from database
 */

class PlantReading {
  String name;
  int maxTemp;
  int maxHumid;
  int lightStart;
  int lightEnd;
  int duration;
  int frequency;
  String plantType;

  PlantReading({
    this.name,
    this.maxTemp,
    this.maxHumid,
    this.lightStart,
    this.lightEnd,
    this.duration,
    this.frequency,
    this.plantType,
  });

  factory PlantReading.fromJson(Map<String, dynamic> json) => PlantReading(
    name: json["name"],
    maxTemp: json["maxTemp"],
    maxHumid: json["maxHumid"],
    lightStart: json["lightStart"],
    lightEnd: json["lightEnd"],
    duration: json["duration"],
    frequency: json["frequency"],
    plantType: json["plantType"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "maxTemp": maxTemp,
    "maxHumid": maxHumid,
    "lightStart": lightStart,
    "lightEnd": lightEnd,
    "duration": duration,
    "frequency": frequency,
    "plantType": plantType,
  };
}