import 'package:flutter/material.dart';

class TextFieldProperties {
  ///Callback for value selected
  final Function(String) onValueSelect;

  ///Suggestion list
  final List<String> data;

  ///Textfield hint text
  final String hint;

  ///Textfield hint text color
  final Color hintColor;

  ///Textfield label text
  final String label;

  ///Textfield label text color
  final Color labelColor;

  ///Suggestion Icon
  final Icon icon;

  ///Textfield contaoiner elevation
  final double elevation;

  ///Textfield controller
  final TextEditingController controller;

  ///Textfield height
  final double fieldHeight;

  ///Error message when no suggestions are available. default error is: No suggestions available
  final String error;

  ///Backgroudn color for field container
  final Color backgroundColor;

  TextFieldProperties({
    @required this.onValueSelect,
    @required this.data,
    this.hint,
    this.hintColor,
    this.label,
    this.labelColor,
    this.icon,
    this.elevation,
    this.controller,
    this.fieldHeight = 90,
    this.error,
    this.backgroundColor,
  }) : assert(onValueSelect != null && data != null && fieldHeight >= 90);
}
