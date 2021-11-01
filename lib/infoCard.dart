import 'package:flutter/material.dart';
import 'textWidget.dart';
import 'tempStatistics.dart';

///Displays an info card

class InfoCard extends StatefulWidget {
  final String _title;
  final String _subtitle;
  final Color _color;
  final IconData _icon;
  final int _shelfNum;

  ///Constructor
  InfoCard(this._title, this._subtitle, this._color, this._icon, this._shelfNum);

  @override
  State<StatefulWidget> createState() => _InfoCard(_title, _subtitle, _color, _icon, _shelfNum);
}

///States allow us to change variables dynamically
class _InfoCard extends State<InfoCard> {
  String _title;
  String _subtitle;
  Color _color;
  IconData _icon;
  int _shelfNum;
  ///Roundness of card corners
  static double _roundness = 10.0;
  ///Rounded rectangle shape
  final _roundedRect = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_roundness)));

  ///Constructor
  _InfoCard(this._title, this._subtitle, this._color, this._icon, this._shelfNum);

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
                  if (_subtitle == 'Temperature') {
                    // go to statistics page
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TempStatistics(_shelfNum)));
                  } else if (_subtitle == 'Humidity') {
                    print(_shelfNum);
                  } else {}
                },
                child: Row(children: [
                    ///Icon + icon background
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: _color,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(_roundness),
                                bottomLeft: Radius.circular(_roundness),
                            )
                        ),
                        child: Icon(_icon, color: Colors.white, size: 40.0)
                    ),
                    ///Text display
                    Flexible(
                        child: ListTile(
                            title: TextWidget(
                                _title,
                                DefaultTextStyle.of(context).style.fontFamily,
                                Colors.black87,
                                FontWeight.w600,
                                35.0
                            ),
                            subtitle: TextWidget(
                                _subtitle,
                                DefaultTextStyle.of(context).style.fontFamily,
                                Colors.black,
                                FontWeight.w300,
                                15.0
                            )
                        )
                    )
                ])
            )
        )
    );
  }
}
