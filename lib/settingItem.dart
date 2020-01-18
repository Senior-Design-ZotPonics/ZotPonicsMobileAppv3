import 'package:flutter/material.dart';
import 'textWidget.dart';
import 'inputDialog.dart';

///Display general listing on the settings menu

class SettingItem extends StatefulWidget {
  final String _title;
  final int _value;
  final String prefix;
  final String suffix;
  final IconData _icon;
  final String _font;

  ///Constructor
  SettingItem(this._title, this._value, this._icon, this._font, {this.prefix = '', this.suffix = ''});

  @override
  State<StatefulWidget> createState() => _SettingItem(_title, _value, prefix, suffix, _icon, _font);
}

///States allow us to change variables dynamically
class _SettingItem extends State<SettingItem> {
  final String _title;
  final String _prefix;
  final String _suffix;
  final IconData _icon;
  final String _font;

  int _value;

  ///Constructor
  _SettingItem(this._title, this._value, this._prefix, this._suffix, this._icon, this._font);

  int getValue() {
    return _value;
  }

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
                _prefix + '$_value' + _suffix,
                _font,
                Colors.black,
                FontWeight.w300,
                15.0
            ),
            onTap: () {
              ///When setting tapped, display input dialog
              showDialog<String>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    ///Number input dialog
                    return InputDialog(_title, _font, true, min: 0, max: 100);
                  }).then((returnValue) {
                    if (returnValue != null) {
                      setState(() { _value = int.parse(returnValue); });
                    }
                  }
              );
            }
        )
    );
  }
}
