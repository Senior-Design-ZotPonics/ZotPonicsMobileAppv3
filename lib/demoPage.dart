import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'demoCard.dart';
import 'services.dart';
import 'textWidget.dart';

///Demo page

class DemoPage extends StatefulWidget {
  final String _font;

  ///Constructor
  DemoPage(this._font);

  @override
  State<StatefulWidget> createState() => _DemoPage(_font);
}


class _DemoPage extends State<DemoPage> {
  final String _font;

  ///Controller objects to read DemoCard inputs
  final baselevelnotify = TextEditingController(text: "0");
  final fanvents = TextEditingController(text: "0");
  final lights = TextEditingController(text: "0");
  final vents = TextEditingController(text: "0");
  final water = TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();

    ///Listen to input changes and call postValues()
    baselevelnotify.addListener(postValues);
    fanvents.addListener(postValues);
    lights.addListener(postValues);
    vents.addListener(postValues);
    water.addListener(postValues);

    postValues();
  }

  ///Required method to dispose of controllers
  @override
  void dispose() {
    baselevelnotify.dispose();
    fanvents.dispose();
    lights.dispose();
    vents.dispose();
    water.dispose();
    super.dispose();
  }

  ///Constructor
  _DemoPage(this._font);

  ///Post demo values to database
  postValues() {
    DemoPostPut post = DemoPostPut(
        writings: [ DemoWriting(
            baselevelnotify: int.parse(baselevelnotify.text),
            fanvents: int.parse(fanvents.text),
            lights: int.parse(lights.text),
            vents: int.parse(vents.text),
            water: int.parse(water.text)
        )]
    );

    postDemoValues(post).then((response) {
      if(response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
            ///Modifies height of AppBar
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
                ///Back button
                leading: IconButton(
                    padding: EdgeInsets.only(top: 12.0),
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                    iconSize: 35.0,
                    splashColor: Colors.transparent,
                    ///Go back to home page
                    onPressed: () => Navigator.of(context).pop()
                ),
                title: Text(
                    'Demo Mode',
                    style: TextStyle(
                        height: 1.8,
                        fontFamily: _font,
                        fontWeight: FontWeight.w600,
                        fontSize: 36.0,
                        color: Colors.white
                    )
                )
            )
        ),
        ///Info cards
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DemoCard('Vents', Colors.orange, FontAwesomeIcons.doorOpen, vents),
              DemoCard('Fans', Colors.cyan, FontAwesomeIcons.fan, fanvents),
              DemoCard('Lights', Colors.yellow, FontAwesomeIcons.lightbulb, lights),
              DemoCard('Pumps', Colors.blue, FontAwesomeIcons.tint, water),
            ]
        )
    );
  }
}
