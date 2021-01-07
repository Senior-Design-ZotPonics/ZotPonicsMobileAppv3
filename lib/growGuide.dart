import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'textWidget.dart';
import 'hydroponicsOverview.dart';
import 'gettingStarted.dart';
import 'hydroponicGardening.dart';
import 'systemMaintenance.dart';

///Currently only has hard-coded profiles
///If we were to allow users to add their own profiles or load from the database,
///this would require a bit more work

///Guide page with various topics for beginners

class GrowGuide extends StatefulWidget {
  final String _font;

  ///Constructor
  GrowGuide(this._font);

  @override
  State<StatefulWidget> createState() => _GrowGuide(_font);
}


class _GrowGuide extends State<GrowGuide> {
  final String _font;

  ///Constructor
  _GrowGuide(this._font);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Off-white background
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: PreferredSize(
          ///Modifies height of AppBar
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
                automaticallyImplyLeading: false, ///Removes automatically included back button
                title: Text(
                    'Guide',
                    style: TextStyle(
                        height: 1.5,
                        fontFamily: _font,
                        fontWeight: FontWeight.w600,
                        fontSize: 36.0,
                        color: Colors.white
                    )
                ),
                actions: [
                  ///X button
                  Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 2.0),
                      child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          iconSize: 35.0,
                          splashColor: Colors.transparent,
                          ///Go to previous page
                          onPressed: () => Navigator.of(context).pop(false) ///Profile not loaded
                      )
                  )
                ]
            )
        ),
        ///Topics list view
        body: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
            ListTile(
                  title: TextWidget("What is hydroponics?", _font, Colors.black, FontWeight.w500, 25.0),
                  onTap: () {
                    ///Redirect to hydroponics overview page
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HydroponicsOverview(_font)));
                  }
              ),
            Divider(height: 0.0, color: Colors.black),
            ListTile(
                title: TextWidget("Getting started", _font, Colors.black, FontWeight.w500, 25.0),
                onTap: () {
                  ///Redirect to getting started page
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GettingStarted(_font)));
                }
            ),
            Divider(height: 0.0, color: Colors.black),
            ListTile(
                title: TextWidget("Hydroponic gardening", _font, Colors.black, FontWeight.w500, 25.0),
                onTap: () {
                  ///Redirect to hydroponic gardening page
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HydroponicGardening(_font)));
                }
              ),
            Divider(height: 0.0, color: Colors.black),
            ListTile(
                title: TextWidget("System maintenance", _font, Colors.black, FontWeight.w500, 25.0),
                onTap: () {
                  ///Redirect to topic page
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SystemMaintenance(_font)));
                }
              ), //what plants can i grow?
          ]
        ).toList(),
        )
    );
  }
}