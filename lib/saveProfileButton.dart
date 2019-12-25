import 'package:flutter/material.dart';
import 'textWidget.dart';
import 'inputDialog.dart';

///Display floating save profile button

class SaveProfileButton extends StatefulWidget {
  final String _font;

  ///Constructor
  SaveProfileButton(this._font);

  @override
  State<StatefulWidget> createState() => _SaveProfileButton(_font);
}

///States allow us to change variables dynamically
class _SaveProfileButton extends State<SaveProfileButton> {
  final String _font;
  String _name;

  ///Constructor
  _SaveProfileButton(this._font);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        label: TextWidget(
            'Save Profile',
            _font,
            Colors.white,
            FontWeight.w600,
            20.0
        ),
        onPressed: () {
          ///When button pressed, display input dialog
          showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                ///String input dialog
                return InputDialog('Save Profile As', _font, false);
              }).then((returnName) {
                if (returnName != null) {
                  setState(() { _name = returnName; });
                  ///Show bar on bottom of screen confirming entry
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                          ),
                          duration: Duration(seconds: 3),
                          content: Text('Saved as $_name')
                      )
                  );
                }
              }
          );
        }
    );
  }
}
