//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'demoCard.dart';
//import 'services.dart';
//import 'textWidget.dart';
//
/////Demo page of the app
//
//class DemoPage extends StatefulWidget {
//  final String _font;
//
//  ///Constructor
//  DemoPage(this._font);
//
//  @override
//  State<StatefulWidget> createState() => _DemoPage(_font);
//}
//
//
//class _DemoPage extends State<DemoPage> {
//  final String _font;
//
//  ///Controller objects to read DemoCard inputs
//  final fanvents = TextEditingController();
//  final lights = TextEditingController();
//  final vents = TextEditingController();
//  final water = TextEditingController();
//
//  ///Constructor
//  _DemoPage(this._font);
//
//  ///Post demo values to database
//  postValues() {
//    PostPut post = PostPut(
//        writings: [ Writing(
//            lightStart: int.parse(lightStart.text),
//            lightEnd: int.parse(lightEnd.text),
//            humidity: int.parse(maxHumid.text),
//            temp: int.parse(maxTemp.text),
//            waterFreq: int.parse(frequency.text),
//            waterDuration: int.parse(duration.text),
//            nutrientRatio: int.parse(nutrientRatio.text),
//            baseLevel: int.parse(baseLevel.text)
//        )]
//    );
//
//    postControlGrowth(post).then((response) {
//      if(response.statusCode > 200)
//        print(response.body);
//      else
//        print(response.statusCode);
//    }).catchError((error) {
//      print('error : $error');
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        ///Off-white background
//        backgroundColor: const Color(0xFFF8F8F8),
//        appBar: PreferredSize(
//            ///Modifies height of AppBar
//            preferredSize: Size.fromHeight(70.0),
//            child: AppBar(
//                title: Text(
//                    'ZotPonics Demo',
//                    style: TextStyle(
//                        height: 2,
//                        fontFamily: _font,
//                        fontWeight: FontWeight.w700,
//                        fontSize: 40.0,
//                        color: Colors.white)
//                )
//            )
//        ),
//        ///Info cards
//        body: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              DemoCard('Fans', Colors.cyan, FontAwesomeIcons.fan),
//              DemoCard('Lights', Colors.yellow, FontAwesomeIcons.lightbulb),
//              DemoCard('Pumps', Colors.blue, FontAwesomeIcons.tint),
//              DemoCard('Vents', Colors.orange, FontAwesomeIcons.doorOpen)
//            ]
//        )
//    );
//  }
//}
