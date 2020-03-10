import 'package:flutter/material.dart';
import 'textWidget.dart';

///Displays a demo card

class DemoCard extends StatefulWidget {
  final String _title;
  final Color _color;
  final IconData _icon;
  final _controller;

  ///Constructor
  DemoCard(this._title, this._color, this._icon, this._controller);

  @override
  State<StatefulWidget> createState() => _DemoCard(_title, _color, _icon, _controller);
}

///States allow us to change variables dynamically
class _DemoCard extends State<DemoCard> {
  String _title;
  Color _color;
  IconData _icon;
  TextEditingController _controller;
  bool _switch;

  ///Roundness of card corners
  static double _roundness = 10.0;
  ///Rounded rectangle shape
  final _roundedRect = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_roundness)));

  ///Constructor
  _DemoCard(title, color, icon, controller) {
    this._title = title;
    this._color = color;
    this._icon = icon;
    this._controller = controller;
    _switch = int.parse(_controller.text) == 1;
  }

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
            child: Row(children: [
                ///Icon + icon background
                Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(_roundness),
                            bottomLeft: Radius.circular(_roundness),
                        )
                    ),
                    child: Icon(_icon, color: Colors.white, size: 45.0)
                ),
                ///Text display
                Flexible(
                    child: ListTile(
                        title: TextWidget(
                            _title,
                            DefaultTextStyle.of(context).style.fontFamily,
                            Colors.black87,
                            FontWeight.w600,
                            30.0
                        )
                    )
                ),
                ///Switch
                Container(
                    width: 70,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: Switch(
                        value: _switch,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            _switch = value;
                            _controller.text = value ? "1" : "0";
                          });
                        }
                    )
                )
            ])
        )
    );
  }
}
