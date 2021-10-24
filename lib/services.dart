//Generated with: https://app.quicktype.io/
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

///To modify IP address, check initState() in homePage.dart

String url = 'http://192.168.0.47:5000';
String sensorData = '/recentsensordata?shelf_number=';
String controlGrowth = '/usercontrolgrowth?shelf_number=';
String userDemo = '/userdemo?shelf_number=';


///Sensor GET///////////////////////////////////////////////////////////////////
//Executes the get api
Future<SensorPostGet> getSensorData(int shelfNum) async{
  final response = await http.get(Uri.parse(url + sensorData + shelfNum.toString()));
  return sensorPostFromJson(response.body);
}

//This function is used to get JSON data from the ZotPonics Server
SensorPostGet sensorPostFromJson(String str) => SensorPostGet.fromJson(json.decode(str));

//This class is used with the get api call and uses a Reading Object
class SensorPostGet {
  List<SensorReading> readings;

  SensorPostGet({ this.readings });

  factory SensorPostGet.fromJson(Map<String, dynamic> json) => SensorPostGet(
       readings: List<SensorReading>.from(json["readings"].map((x) => SensorReading.fromJson(x))));
}

class SensorReading {
  double baseLevel;
  double humidity;
  DateTime lastWateredTimestamp;
  dynamic lightStatus;
  double shelfNumber;
  double temperature;
  DateTime timestamp;

  SensorReading({
    this.baseLevel,
    this.humidity,
    this.lastWateredTimestamp,
    this.lightStatus,
    this.shelfNumber,
    this.temperature,
    this.timestamp
  });

  factory SensorReading.fromJson(Map<String, dynamic> json) => SensorReading(
      baseLevel: json["baseLevel"],
      humidity: json["humidity"],
      lastWateredTimestamp: DateTime.parse(json["lastWateredTimestamp"]),
      lightStatus: json["lightStatus"],
      shelfNumber: json["shelf_number"],
      temperature: json["temperature"],
      timestamp: DateTime.parse(json["timestamp"])
    );
}


///Control Growth GET and POST//////////////////////////////////////////////////
//Executes the get api
Future<CGPostGet> getControlGrowth(int shelfNumber) async{
  //debugPrint(url + controlGrowth + shelfNumber.toString());
  final response = await http.get(Uri.parse(url + controlGrowth + shelfNumber.toString()));
  //debugPrint(response.body);
  return CGPostFromJson(response.body);
}

//This function is used to get JSON data from the ZotPonics Server
CGPostGet CGPostFromJson(String str) => CGPostGet.fromJson(json.decode(str));

//This class is used with the get api call and uses a Reading Object
class CGPostGet {
  List<CGReading> readings;

  CGPostGet({ this.readings });

  factory CGPostGet.fromJson(Map<String, dynamic> json) => CGPostGet(
      readings: List<CGReading>.from(json["readings"].map((x) => CGReading.fromJson(x)))
  );
}

class CGReading {
  double baseLevel;
  double humidity;
  double lightStart;
  double lightEnd;
  double shelfNumber;
  double temperature;
  DateTime timestamp;
  double waterFreq;
  double waterDuration;

  CGReading({
    this.baseLevel,
    this.humidity,
    this.lightStart,
    this.lightEnd,
    this.shelfNumber,
    this.temperature,
    this.timestamp,
    this.waterFreq,
    this.waterDuration
  });

  factory CGReading.fromJson(Map<String, dynamic> json) => CGReading(
      baseLevel: json["baseLevel"],
      humidity: json["humidity"],
      lightStart: json["lightStartTime"],
      lightEnd: json["lightEndTime"],
      shelfNumber: json["shelf_number"],
      temperature: json["temperature"],
      timestamp: DateTime.parse(json["timestamp"]),
      waterFreq: json["waterFreq"],
      waterDuration: json["waterDuration"]
  );
}

//Executes the put api
Future<http.Response> postControlGrowth(CGPostPut post, int shelfNumber) async{
  final response = await http.post(Uri.parse(url + controlGrowth + shelfNumber.toString())
      ,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postCGToJson(post)
  );
  return response;
}

//This function is used to post JSON data to the ZotPonics Server
String postCGToJson(CGPostPut data) => json.encode(data.toJson());

//This class is used with the put api and used with a Writing Object
class CGPostPut {
  List<CGWriting> writings;

  CGPostPut({ this.writings });

  Map<String, dynamic> toJson() => {
    "controlfactors": List<dynamic>.from(writings.map((x) => x.toJson()))
  };
}

class CGWriting {
  int baseLevel;
  int humidity;
  int lightStart;
  int lightEnd;
  int shelfNumber;
  int temp;
  String timestamp;
  int waterFreq;
  int waterDuration;

  CGWriting({
    this.shelfNumber,
    this.baseLevel,
    this.humidity,
    this.lightStart,
    this.lightEnd,
    this.timestamp,
    this.temp,
    this.waterFreq,
    this.waterDuration
  });

  Map<String,dynamic> toJson() => {
    "baselevel": baseLevel,
    "humidity": humidity,
    "lightstart": lightStart,
    "lightend": lightEnd,
    "nutrientratio": 50, /// filler value to match flask_app.py
    "shelf_number": shelfNumber,
    "temp": temp,
    "timestamp": timestamp,
    "waterfreq": waterFreq,
    "waterdur": waterDuration
  };
}


///User Demo GET and POST///////////////////////////////////////////////////////
//Executes the get api
Future<DemoPostGet> getDemoValues(int shelfNumber) async{
  final response = await http.get(Uri.parse(url + userDemo + shelfNumber.toString()));
  return DemoPostFromJson(response.body);
}

//This function is used to get JSON data from the ZotPonics Server
DemoPostGet DemoPostFromJson(String str) => DemoPostGet.fromJson(json.decode(str));

//This class is used with the get api call and uses a Reading Object
class DemoPostGet {
  List<DemoReading> readings;

  DemoPostGet({ this.readings });

  factory DemoPostGet.fromJson(Map<String, dynamic> json) => DemoPostGet(
      readings: List<DemoReading>.from(json["readings"].map((x) => DemoReading.fromJson(x)))
  );
}

class DemoReading {
  int baselevelnotify;
  int fanvents;
  int lights;
  int vents;
  int water;

  DemoReading({
    this.baselevelnotify,
    this.fanvents,
    this.lights,
    this.vents,
    this.water
  });

  factory DemoReading.fromJson(Map<String, dynamic> json) => DemoReading(
      baselevelnotify: json["baselevelnotify"],
      fanvents: json["fanvents"],
      lights: json["lights"],
      vents: json["vents"],
      water: json["water"]
  );
}

//Executes the put api
Future<http.Response> postDemoValues(DemoPostPut post, int shelfNumber) async{
  final response = await http.post(Uri.parse(url + userDemo + shelfNumber.toString())
      ,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postDemoToJson(post)
  );
  return response;
}

//This function is used to post JSON data to the ZotPonics Server
String postDemoToJson(DemoPostPut data) => json.encode(data.toJson());

//This class is used with the put api and used with a Writing Object
class DemoPostPut {
  List<DemoWriting> writings;

  DemoPostPut({ this.writings });

  Map<String, dynamic> toJson() => {
    "user_demo": List<dynamic>.from(writings.map((x) => x.toJson()))
  };
}

class DemoWriting {
  int baselevelnotify;
  int fanvents;
  int lights;
  int vents;
  int water;

  DemoWriting({
    this.baselevelnotify,
    this.fanvents,
    this.lights,
    this.vents,
    this.water
  });

  Map<String,dynamic> toJson() => {
    "baselevelnotify": baselevelnotify,
    "fanvents": fanvents,
    "lights": lights,
    "vents": vents,
    "water": water
  };
}