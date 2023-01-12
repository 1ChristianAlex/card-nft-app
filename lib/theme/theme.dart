import 'package:flutter/material.dart';

var currentTheme = ThemeData(
  primarySwatch: Colors.blue,
  backgroundColor: const Color.fromRGBO(44, 47, 51, 1),
  textTheme: const TextTheme(bodyMedium: TextStyle()),
);

class AppTheme {
  static const blurple = Color.fromRGBO(88, 101, 242, 1);
  static const green = Color.fromRGBO(88, 242, 135, 1);
  static const yellow = Color.fromRGBO(254, 231, 92, 1);
  static const fuchsia = Color.fromRGBO(235, 69, 158, 1);
  static const red = Color.fromRGBO(237, 66, 69, 1);

  static const softBlack = Color.fromRGBO(44, 47, 51, 1);

  static const white = Colors.white;
  static const black = Colors.black;

  static const double spacing = 8;
}
