import 'package:flutter/material.dart';

///Return a text widget based on input parameters

class TextWidget extends StatelessWidget {
  final String _text;
  final String _font;
  final Color _color;
  final FontWeight _weight;
  final double _size;

  ///Constructor
  TextWidget(this._text, this._font, this._color, this._weight, this._size);

  @override
  Widget build(BuildContext context) {
    return Text(
        _text,
        style: TextStyle(
            fontFamily: _font,
            color: _color,
            fontWeight: _weight,
            fontSize: _size
        )
    );
  }
}
