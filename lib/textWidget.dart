import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String _text;
  String _font;
  Color _color;
  FontWeight _weight;
  double _size;

  TextWidget(String text, String font, Color color, FontWeight weight, double size) {
    this._text = text;
    this._font = font;
    this._color = color;
    this._weight = weight;
    this._size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(_text, style: TextStyle(fontFamily: _font,
        fontWeight: _weight,
        fontSize: _size,
        color: _color));
  }
}