import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    try {
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      } else {
        return int.parse("FF000000", radix: 16);
      }
      return int.parse(hexColor, radix: 16);
    } catch (e) {
      return int.parse("FF000000", radix: 16);
    }
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
