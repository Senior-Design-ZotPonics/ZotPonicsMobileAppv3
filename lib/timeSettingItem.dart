import 'package:flutter/material.dart';
import 'textWidget.dart';

///Display time setting listing on the settings menu

class TimeSettingItem extends StatefulWidget {
  final String _title;
  final int _start;
  final int _end;
  final IconData _icon;
  final String _font;

  ///Constructor
  TimeSettingItem(this._title, this._start, this._end, this._icon, this._font);

  @override
  State<StatefulWidget> createState() => _TimeSettingItem(_title, _start, _end, _icon, _font);
}

///States allow us to change variables dynamically
class _TimeSettingItem extends State<TimeSettingItem> {
  final String _title;
  final IconData _icon;
  final String _font;
  int _start;
  int _end;

  ///Constructor
  _TimeSettingItem(this._title, this._start, this._end, this._icon, this._font);

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
                '$_start:00 - $_end:00',
                _font,
                Colors.black,
                FontWeight.w300,
                15.0
            ),
            onTap: () {
              ///When setting tapped, display start time input dialog
              showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: _start, minute: 0)
              ).then((returnTime) {
                  if (returnTime != null) {
                    setState(() { _start = returnTime.hour; });

                    ///After start time inputted, display end time input dialog
                    showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: _end, minute: 0)
                    ).then((returnTime) {
                        if (returnTime != null) {
                          setState(() { _end = returnTime.hour; });
                        }
                    });
                  }
              });
            }
        )
    );
  }
}
