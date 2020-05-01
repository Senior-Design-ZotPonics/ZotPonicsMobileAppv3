import 'package:flutter/material.dart';
import 'textWidget.dart';

///Display time setting listing on the settings menu

class TimeSettingItem extends StatefulWidget {
  final String _title;
  final IconData _icon;
  final String _font;
  final _controller;

  ///Constructor
  TimeSettingItem(this._title, this._controller, this._icon, this._font);

  @override
  State<StatefulWidget> createState() => _TimeSettingItem(_title, _controller, _icon, _font);
}

///States allow us to change variables dynamically
class _TimeSettingItem extends State<TimeSettingItem> {
  final String _title;
  final IconData _icon;
  final String _font;
  final _controller;

  ///Constructor
  _TimeSettingItem(this._title, this._controller, this._icon, this._font);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        child: ListTile(
            ///Icon
            leading: Container(
                height: 35.0,
                width: 40.0,
                child: Icon(_icon, color: Colors.green, size: 35.0)
            ),
            title: TextWidget(
                _title,
                _font,
                Colors.black87,
                FontWeight.w600,
                20.0
            ),
            subtitle: TextWidget(
                '${_controller.text}:00',
                _font,
                Colors.black,
                FontWeight.w300,
                15.0
            ),
            onTap: () {
              ///When setting tapped, display time input dialog
              showTimePicker(
                  context: context,
                  ///Only records hour value
                  initialTime: TimeOfDay(hour: int.parse(_controller.text), minute: 0)
              ).then((returnTime) {
                  if (returnTime != null) {
                    setState(() { _controller.text = returnTime.hour.toString(); });
                  }
              });
            }
        )
    );
  }
}
