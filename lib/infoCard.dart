import 'package:flutter/material.dart';
import 'textWidget.dart';

///Displays a single info card on the home screen

class InfoCard extends StatefulWidget {
  final String _title;
  final String _subtitle;
  final Color _color;
  final IconData _icon;

  InfoCard(this._title, this._subtitle, this._color, this._icon); ///Constructor

  @override
  State<StatefulWidget> createState() => _InfoCard(_title, _subtitle, _color, _icon);
}

class _InfoCard extends State<InfoCard> {
  ///Allows us to change text dynamically
  String _title;
  String _subtitle;
  Color _color;
  IconData _icon;
  static double _roundness = 10.0; ///Roundness of card corners

  final _roundedRect = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_roundness)));

  _InfoCard(this._title, this._subtitle, this._color, this._icon);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        ///Drop shadow
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_roundness)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3.0,
                  spreadRadius: -1.0,
                  offset: Offset(0, 2)),
            ]),
        child: Card(
          shape: _roundedRect,
          ///Makes the cool splash effect
          child: InkWell(
            customBorder: _roundedRect,
            splashColor: _color.withAlpha(1000),
            onTap: () {
              setState(() {
                _title = 'Changed';
              });
            },
            child: Row(
              children: [
                ///Icon + icon background
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_roundness),
                          bottomLeft: Radius.circular(_roundness),
                        )),
                    child: Icon(_icon, color: Colors.white, size: 40.0)),
                ///Text display
                Flexible(
                  child: ListTile(
                    title: TextWidget(
                        _title,
                        DefaultTextStyle.of(context).style.fontFamily,
                        Colors.black87,
                        FontWeight.w600,
                        35.0),
                    subtitle: TextWidget(
                        _subtitle,
                        DefaultTextStyle.of(context).style.fontFamily,
                        Colors.black,
                        FontWeight.w300,
                        15.0),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
