import 'package:flutter/material.dart';
import 'textWidget.dart';

///Display listing on the settings menu

class InputDialog extends StatefulWidget {
  final String _title;
  final String _font;
  final bool _isNum;
  final int min;
  final int max;

  ///Constructor
  InputDialog(this._title, this._font, this._isNum, {this.min = 0, this.max = 0});

  @override
  State<StatefulWidget> createState() {
    if (_isNum) {
      return _InputDialog(_title, 'Enter an integer', _font, min, max, true);
    } else {
      return _InputDialog(_title, 'Name', _font, 0, 0, false);
    }
  }
}

///States allow us to change variables dynamically
class _InputDialog extends State<InputDialog> {
  final String _title;
  final String _label;
  final String _font;
  final int _min;
  final int _max;
  final bool _isNum;

  String _errorText = 'Please enter a correct value.';
  bool _inputValid = true;

  ///Constructor
  _InputDialog(this._title, this._label, this._font, this._min, this._max, this._isNum);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.all(15.0),
        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        title: TextWidget(
            _title,
            _font,
            Colors.black87,
            FontWeight.w600,
            20.0
        ),
        ///Input field for name
        content: TextField(
            keyboardType: _isNum ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: _label,
                errorText: _inputValid ? null : _errorText
            ),
            ///Input checking
            onChanged: (String input) {
              if (_isNum) { ///Number error checking
                final _num = int.tryParse(input);
                if (input != null && input != '' && _num == null) { ///Not integer
                  setState(() {
                    _errorText = 'Please enter an integer.';
                    _inputValid = false;
                  });
                }
                else {
                  if (_num < _min || _num > _max) { ///Exceeds range
                    setState(() {
                      _errorText = 'Value must be between $_min - $_max.';
                      _inputValid = false;
                    });
                  }
                  else {
                    setState(() => _inputValid = true);
                  }
                }
              }
              else { ///String error checking
                if (input != null && input != '' && int.tryParse(input) != null) { ///Input is number
                  setState(() {
                    _errorText = 'Name cannot be a number.';
                    _inputValid = false;
                  });
                }
                else {
                  setState(() => _inputValid = true);
                }
              }
            },
            onSubmitted: (String input) {
              if (_inputValid && input != null && input != '') {
                ///Exit dialog and return value
                Navigator.of(context, rootNavigator: true).pop(input);
              }
            }
        ),
        ///Cancel button
        actions: [
          FlatButton(
              child: TextWidget(
                  'Cancel',
                  _font,
                  Theme.of(context).primaryColor,
                  FontWeight.w600,
                  15.0
              ),
              onPressed: () {
                ///Return without value
                Navigator.of(context).pop();
              }
          )
        ]
    );
  }
}