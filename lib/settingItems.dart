import 'package:flutter/material.dart';
import 'textWidget.dart';

///Display listing on the settings menu

class SettingItem extends StatefulWidget {
  final String _type;
  final String _title;
  final String _subtitle;
  final IconData _icon;
  final String _font;

  SettingItem(this._type, this._title, this._subtitle, this._icon, this._font);

  @override
  State<StatefulWidget> createState() {
    switch(_type) {
      case 'Number':
        return _NumberItem(_title, _subtitle, _icon, _font);
        break;
      default:
        return _NumberItem(_title, _subtitle, _icon, _font);
        break;
    }
  }
}

class _NumberItem extends State<SettingItem> {
  ///Allows us to change text dynamically
  String _title;
  String _subtitle;
  IconData _icon;
  String _font;
  bool _numberValid = true;
  String _num = '100';

  _NumberItem(this._title, this._subtitle, this._icon, this._font);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Icon(_icon, color: Colors.green, size: 40.0),
            title: TextWidget(
                _title,
                _font,
                Colors.black87,
                FontWeight.w600,
                20.0),
            subtitle: TextWidget(
                '$_num°F',
                _font,
                Colors.black,
                FontWeight.w300,
                15.0),
            onTap: () {
              ///When setting tapped, display input dialog
              showDialog<String>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        titlePadding: EdgeInsets.all(15.0),
                        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        title: TextWidget(
                            _title,
                            _font,
                            Colors.black87,
                            FontWeight.w600,
                            20.0),
                        ///Input field for number
                        content: TextField(
                            keyboardType: TextInputType.number,
                            //controller: _controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter an integer',
                                ///Error display currently doesn't work
                                ///Would require putting dialog in Stateful class, which is a pain
                                errorText: _numberValid ? null : 'Please enter an integer.'),
                            ///Input checking
                            onSubmitted: (String num) {
                              if (num != null && int.tryParse(num) == null) {
                                setState(() => _numberValid = false);
                              } else {
                                setState(() => _numberValid = true);
                                Navigator.of(context, rootNavigator: true).pop(num);
                              }
                            }),
                        ///Cancel button
                        actions: [
                          FlatButton(
                            child: TextWidget(
                                'Cancel',
                                _font,
                                Theme.of(context).primaryColor,
                                FontWeight.w600,
                                15.0),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ]
                        );
                  }).then((returnNum) {
                        if (returnNum != null) {
                          setState(() { _num = returnNum; });
                        }
                  }
              );
            },
        )
    );
  }
}
