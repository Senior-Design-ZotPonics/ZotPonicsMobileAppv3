import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';

///System maintenance page - how to take care of the system, especially if something breaks

class SystemMaintenance extends StatefulWidget {
  final String _font;

  ///Constructor
  SystemMaintenance(this._font);

  @override
  State<StatefulWidget> createState() => _SystemMaintenance(_font);
}

class _SystemMaintenance extends State<SystemMaintenance> {

  final String _font;

  ///Constructor
  _SystemMaintenance(this._font);

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
                    'System maintenance',
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
                      child: TextWidget("The ZotPonics system is self-sufficient, but it requires some occasional maintenance. "
                          "As you may already know, the nutrient water must be replaced every two weeks. When doing so, dump out "
                          "the existing water and make sure to wipe down the reservoir before adding the fresh batch of nutrient "
                          "water.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("It is also ideal to clean the tubes whenever you replace the nutrient water. The tubes "
                          "can be disconnected from the reservoir and the troughs, and should be run under fresh water to rinse "
                          "out any nutrient residue and prevent mold from growing. Make sure to secure the tubes when reconnecting "
                          "them to the system, so that no nutrient water escapes once the water is pumping again.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  )
                ]
            )
        )
    );
  }
}
