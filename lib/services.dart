//Generated with: https://app.quicktype.io/
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

///To modify IP address, check initState() in homePage.dart

String url = 'http://okyang.pythonanywhere.com';
String sensorData = '/recentsensordata';
String controlGrowth = '/usercontrolgrowth';
String userDemo = '/userdemo';


///Sensor GET///////////////////////////////////////////////////////////////////
//Executes the get api
Future<SensorPostGet> getSensorData() async{
  final response = await http.get(url + sensorData);
  return sensorPostFromJson(response.body);
}

//This function is used to get JSON data from the ZotPonics Server
SensorPostGet sensorPostFromJson(String str) => SensorPostGet.fromJson(json.decode(str));

//This class is used with the get api call and uses a Reading Object
class SensorPostGet {
  List<SensorReading> readings;

  SensorPostGet({ this.readings });

  factory SensorPostGet.fromJson(Map<String, dynamic> json) => SensorPostGet(
      readings: List<SensorReading>.from(json["readings"].map((x) => SensorReading.fromJson(x)))
  );
}

class SensorReading {
  DateTime timestamp;
  double temperature;
  double humidity;
  double baseLevel;
  double plantHeight;
  DateTime lastWateredTimestamp;
  dynamic lightStatus;

  SensorReading({
    this.timestamp,
    this.temperature,
    this.humidity,
    this.baseLevel,
    this.plantHeight,
    this.lastWateredTimestamp,
    this.lightStatus
  });

  factory SensorReading.fromJson(Map<String, dynamic> json) => SensorReading(
      timestamp: DateTime.parse(json["timestamp"]),
      temperature: json["temperature"],
      humidity: json["humidity"],
      baseLevel: json["baseLevel"],
      plantHeight: json["plantHeight"],
      lastWateredTimestamp: DateTime.parse(json["lastWateredTimestamp"]),
      lightStatus: json["lightStatus"]
  );
}


///Control Growth GET and POST//////////////////////////////////////////////////
//Executes the get api
Future<CGPostGet> getControlGrowth() async{
  final response = await http.get(url + controlGrowth);
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
  DateTime timestamp;
  double lightStart;
  double lightEnd;
  double humidity;
  double temperature;
  double waterFreq;
  double waterDuration;
  double nutrientRatio;
  double baseLevel;

  CGReading({
    this.timestamp,
    this.lightStart,
    this.lightEnd,
    this.humidity,
    this.temperature,
    this.waterFreq,
    this.waterDuration,
    this.nutrientRatio,
    this.baseLevel
  });

  factory CGReading.fromJson(Map<String, dynamic> json) => CGReading(
      timestamp: DateTime.parse(json["timestamp"]),
      lightStart: json["lightStartTime"],
      lightEnd: json["lightEndTime"],
      humidity: json["humidity"],
      temperature: json["temperature"],
      waterFreq: json["waterFreq"],
      waterDuration: json["waterDuration"],
      nutrientRatio: json["nutrientRatio"],
      baseLevel: json["baseLevel"]
  );
}

//Executes the put api
Future<http.Response> postControlGrowth(CGPostPut post) async{
  final response = await http.post(
      url + controlGrowth,
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
  String timestamp;
  int lightStart;
  int lightEnd;
  int humidity;
  int temp;
  int waterFreq;
  int waterDuration;
  int nutrientRatio;
  int baseLevel;

  CGWriting({
    this.timestamp,
    this.lightStart,
    this.lightEnd,
    this.humidity,
    this.temp,
    this.waterFreq,
    this.waterDuration,
    this.nutrientRatio,
    this.baseLevel
  });

  Map<String,dynamic> toJson() => {
    "timestamp": timestamp,
    "lightstart": lightStart,
    "lightend": lightEnd,
    "humidity": humidity,
    "temp": temp,
    "waterfreq": waterFreq,
    "waterdur": waterDuration,
    "nutrientratio": nutrientRatio,
    "baselevel": baseLevel
  };
}


///User Demo GET and POST///////////////////////////////////////////////////////
//Executes the get api
Future<DemoPostGet> getDemoValues() async{
  final response = await http.get(url + userDemo);
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
Future<http.Response> postDemoValues(DemoPostPut post) async{
  final response = await http.post(
      url + userDemo,
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