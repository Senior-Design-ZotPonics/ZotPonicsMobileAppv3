import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'textWidget.dart';

class InfoCard extends StatelessWidget {
  String _title;
  String _subtitle;
  Color _color;
  Icon _icon;

  final _roundedRect = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0))
  );

  InfoCard(String title, String subtitle, Color color, Icon icon) {
    this._title = title;
    this._subtitle = subtitle;
    this._color = color;
    this._icon = icon;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
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
              decoration: new BoxDecoration(
                color: _color,
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0)
                )
              ),
              child: Center(
                child: IconButton(
                  iconSize: 40.0,
                  icon: _icon
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: TextWidget(_title, 'Montserrat', Colors.black, FontWeight.w700, 35.0),
                subtitle: TextWidget(_subtitle, 'Montserrat', Colors.black, FontWeight.w300, 15.0),
              ),
            )

          ],
        ),
      ),
    );
  }
}