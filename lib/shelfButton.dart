import 'package:flutter/material.dart';
import 'textWidget.dart';
import 'systemPage.dart';

///Displays a button that redirects to a shelf's settings page

class ShelfButton extends StatefulWidget {
  final String _title;
  final Color _color;
  final IconData _icon;
  final String _font;
  final int _shelfNum;

  ///Constructor
  ShelfButton(this._title, this._color, this._icon, this._font, this._shelfNum);

  @override
  State<StatefulWidget> createState() => _ShelfButton(_title, _color, _icon, _font, _shelfNum);
}

///States allow us to change variables dynamically
class _ShelfButton extends State<ShelfButton> {
  String _title;
  Color _color;
  IconData _icon;
  String _font;
  int _shelfNum;
  ///Roundness of card corners
  static double _roundness = 10.0;
  ///Rounded rectangle shape
  final _roundedRect = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_roundness)));

  ///Constructor
  _ShelfButton(this._title, this._color, this._icon, this._font, this._shelfNum);

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
                  offset: Offset(0, 2)
              ),
            ]
        ),
        ///Card
        child: Card(
            shape: _roundedRect,
            ///Makes cool splash effect and adds tap ability
            child: InkWell(
                customBorder: _roundedRect,
                splashColor: _color.withAlpha(1000),
                onTap: () {
                  ///Go to shelf page
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SystemPage(_font, _shelfNum)));
                },
                child: Row(
                    children: [
                      ///Icon + icon background
                      Container(
                          width: 100,
                          height: 125,
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(_roundness),
                                bottomLeft: Radius.circular(_roundness),
                              )
                          ),
                          child: Icon(_icon, color: Colors.white, size: 70.0)
                      ),
                      ///Text display
                      Flexible(
                          child: TextWidget(
                              '  '+_title,
                              DefaultTextStyle.of(context).style.fontFamily,
                              Colors.black87,
                              FontWeight.w600,
                              35.0
                          )
                      )
                    ])
            )
        )
    );
  }
}
