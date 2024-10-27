import 'package:flutter/material.dart';

class ColorModel {
  int? id;
  String? name;
  String? hexCode;

  ColorModel({
    this.id,
    this.name,
    this.hexCode,
  });

  ColorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hexCode = json['hex_code'];
  }

  Color get  getColorFromHex {
    try {
      return _getColorFromHex(hexCode, Colors.black);
    } catch (e) {
      return Colors.black;
    }
  }

  static Color _getColorFromHex(String? hexColor, Color fallbackColor) {
    final colorString = hexColor?.split('#')[1];
    final Color color;

    if (colorString != null) {
      final colorValue = int.parse(colorString.length == 8 ? colorString : 'FF$colorString', radix: 16);
      color = Color(colorValue);
    } else {
      color = fallbackColor;
    }

    return color;
  }
}
