import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';

///Hydroponics overview page - explaining hydroponics and how it can be done from home

class HydroponicsOverview extends StatefulWidget {
  final String _font;

  ///Constructor
  HydroponicsOverview(this._font);

  @override
  State<StatefulWidget> createState() => _HydroponicsOverview(_font);
}

class _HydroponicsOverview extends State<HydroponicsOverview> {

  final String _font;

  ///Constructor
  _HydroponicsOverview(this._font);

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
                    'What is hydroponics?',
                    style: TextStyle(
                        height: 1.8,
                        fontFamily: _font,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        color: Colors.white
                    )
                )
            )
        ),
        ///Setting items
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Hydroponics is the method of growing plants in nutrient-rich water instead of soil. "
                        "Plants only require water, air, and nutrients to grow, so soil is not necessary! Hydroponics comes "
                        "with many benefits, such as faster and higher yields without pests or weeds. It’s a clean process "
                        "that can happen in places of all sizes with power.", this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Here are some examples of hydroponics systems:",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Image(
                          image: AssetImage('assets/images/horizontal-hp.jpg')
                      )
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Image(
                          image: AssetImage('assets/images/vertical-hp.jpg')
                      )
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Image(
                          image: AssetImage('assets/images/diagonal-hp.jpg')
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("To grow plants hydroponically, the plants are set up in a structure that allows for "
                        "them to be held in place with their roots exposed. The structures can be in all kinds of shapes and "
                        "sizes, as long as the nutrient water can be delivered to the plants. With a well-maintained growth "
                        "environment, the plants can be fully grown to completion. Once the plants have been harvested, the "
                        "process can be started all over again!", this._font, Colors.black, FontWeight.w400, 16.0)
                  )
            ]
            )
        )
        );
  }
}
