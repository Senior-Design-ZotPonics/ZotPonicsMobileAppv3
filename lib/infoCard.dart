import 'package:flutter/material.dart';
import 'textWidget.dart';

class InfoCard extends StatelessWidget {
  String _title;
  String _subtitle;
  Color _color;
  IconData _icon;
  static double _roundness = 10.0;

  final _roundedRect = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_roundness))
  );

  InfoCard(String title, String subtitle, Color color, IconData icon) {
    this._title = title;
    this._subtitle = subtitle;
    this._color = color;
    this._icon = icon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_roundness)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3.0,
            spreadRadius: -1.0,
            offset: Offset(0,2)
          ),
        ]
      ),
      child: Card(
        shape: _roundedRect,
        child: InkWell(
          customBorder: _roundedRect,
          splashColor: _color.withAlpha(1000),
          onTap: () {print('Card tapped.');},
          child: Row(
            children: [
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
              Flexible(
                child: ListTile(
                  title: TextWidget(_title, 'Montserrat', Colors.black87, FontWeight.w600, 35.0),
                  subtitle: TextWidget(_subtitle, 'Montserrat', Colors.black, FontWeight.w300, 15.0),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}