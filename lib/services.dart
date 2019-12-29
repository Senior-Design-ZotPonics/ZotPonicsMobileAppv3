//Generated with: https://app.quicktype.io/
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String get_url = 'http://10.0.1.96:5000/recentsensordata';
String put_url = 'http://10.0.1.96:5000/usercontrolgrowth';

//This function executes the get api using the get_url string
Future<PostGet> getPost() async{
  final response = await http.get('$get_url');
  return postFromJson(response.body);
}

//This function uses the put api using the put_url
Future<http.Response> createPost(PostPut post) async{
  final response = await http.post(
      '$put_url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postToJson(post)
  );
  return response;
}

//This function is used to get JSON data from the ZotPonics Server
PostGet postFromJson(String str) => PostGet.fromJson(json.decode(str));

//This function is used to post JSON data to the ZotPonics Server
String postToJson(PostPut data) => json.encode(data.toJson());

//This class is used with the get api call and uses a Reading Object
class PostGet {
  List<Reading> readings;

  PostGet({ this.readings });

  factory PostGet.fromJson(Map<String, dynamic> json) => PostGet(
      readings: List<Reading>.from(json["readings"].map((x) => Reading.fromJson(x)))
  );

}

class Reading {
  double baseLevel;
  double humidity;
  DateTime lastWateredTimestamp;
  dynamic lightStatus;
  double plantHeight;
  double temperature;
  DateTime timestamp;

  Reading({
    this.baseLevel,
    this.humidity,
    this.lastWateredTimestamp,
    this.lightStatus,
    this.plantHeight,
    this.temperature,
    this.timestamp
  });

  factory Reading.fromJson(Map<String, dynamic> json) => Reading(
      baseLevel: json["baseLevel"],
      humidity: json["humidity"],
      lastWateredTimestamp: DateTime.parse(json["lastWateredTimestamp"]),
      lightStatus: json["lightStatus"],
      plantHeight: json["plantHeight"],
      temperature: json["temperature"],
      timestamp: DateTime.parse(json["timestamp"])
  );
}

//This class is used with the put api and used with a Writing Object
class PostPut {
  List<Writing> writings;
  PostPut({ this.writings });
  Map<String, dynamic> toJson() => {
    "controlfactors": List<dynamic>.from(writings.map((x) => x.toJson()))
  };
}

class Writing {
  String timestamp;
  int lightstart;
  int lightend;
  double humidity;
  double temp;
  double waterfreq;
  double nutrientratio;
  double baselevel;

  Writing({
    this.timestamp,
    this.lightstart,
    this.lightend,
    this.humidity,
    this.temp,
    this.waterfreq,
    this.nutrientratio,
    this.baselevel
  });

  Map<String,dynamic> toJson() => {
    "timestamp": timestamp,
    "lightstart": lightstart,
    "lightend": lightend,
    "humidity": humidity,
    "temp": temp,
    "waterfreq": waterfreq,
    "nutrientratio": nutrientratio,
    "baselevel": baselevel
  };
}