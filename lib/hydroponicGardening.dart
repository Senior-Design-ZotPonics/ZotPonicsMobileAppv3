import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';

///Hydroponic gardening page - recommended plants and how to grow them hydroponically

class HydroponicGardening extends StatefulWidget {
  final String _font;

  ///Constructor
  HydroponicGardening(this._font);

  @override
  State<StatefulWidget> createState() => _HydroponicGardening(_font);
}

class _HydroponicGardening extends State<HydroponicGardening> {

  final String _font;

  ///Constructor
  _HydroponicGardening(this._font);

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
                    'Hydroponic Gardening',
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
                      child: TextWidget("If you don't know what plants to grow, here are some recommendations!",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Plant 1", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor "
                          "incididunt ut labore et dolore magna aliqua. Tellus id interdum "
                          "velit laoreet id donec ultrices tincidunt. Nibh venenatis cras sed felis eget "
                          "velit aliquet sagittis. Suscipit adipiscing bibendum est ultricies. "
                          "Condimentum vitae sapien pellentesque habitant morbi tristique. Purus sit amet "
                          "volutpat consequat. Proin sagittis nisl rhoncus mattis rhoncus urna "
                          "neque. Amet est placerat in egestas erat imperdiet sed. Gravida dictum fusce "
                          "ut placerat orci nulla pellentesque dignissim. Velit euismod in "
                          "pellentesque massa placerat duis ultricies lacus. Sit amet tellus cras adipiscing "
                          "enim. Orci eu lobortis elementum nibh tellus molestie. Tempus "
                          "imperdiet nulla malesuada pellentesque elit. Et netus et malesuada fames ac "
                          "turpis egestas. Dignissim sodales ut eu sem integer vitae justo eget. "
                          "Egestas egestas fringilla phasellus faucibus. Semper risus in hendrerit gravida.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextWidget("Plant 2", this._font, Colors.black, FontWeight.w500, 20.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: TextWidget("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor "
                          "incididunt ut labore et dolore magna aliqua. Tellus id interdum "
                          "velit laoreet id donec ultrices tincidunt. Nibh venenatis cras sed felis eget "
                          "velit aliquet sagittis. Suscipit adipiscing bibendum est ultricies. "
                          "Condimentum vitae sapien pellentesque habitant morbi tristique. Purus sit amet "
                          "volutpat consequat. Proin sagittis nisl rhoncus mattis rhoncus urna "
                          "neque. Amet est placerat in egestas erat imperdiet sed. Gravida dictum fusce "
                          "ut placerat orci nulla pellentesque dignissim. Velit euismod in "
                          "pellentesque massa placerat duis ultricies lacus. Sit amet tellus cras adipiscing "
                          "enim. Orci eu lobortis elementum nibh tellus molestie. Tempus "
                          "imperdiet nulla malesuada pellentesque elit. Et netus et malesuada fames ac "
                          "turpis egestas. Dignissim sodales ut eu sem integer vitae justo eget. "
                          "Egestas egestas fringilla phasellus faucibus. Semper risus in hendrerit gravida.",
                          this._font, Colors.black, FontWeight.w400, 16.0)
                  )
                ]
            )
        )
    );
  }
}
