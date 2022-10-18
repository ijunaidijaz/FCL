import 'package:flutter/material.dart';

final Color kColorPrimary = HexColor("#1E3B7D");
final Color kColorAccent = HexColor("##F7C600");
final Color kColorContainer = Colors.white.withOpacity(0.8509803921568627);
final Color kColorContainerSimple = HexColor('#EAEAEA');

//* Converts hex to int as required by Color class of Flutter
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    String _hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (_hexColor.length == 6) {
      _hexColor = "FF$_hexColor";
    }
    return int.parse(_hexColor, radix: 16);
  }
}
