import 'package:flutter/material.dart';

class ColorUtils {
  ColorUtils._();

  static Color parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return Colors.transparent;
    }

    final hexColor = colorString.replaceAll('#', '');

    try {
      return Color(int.parse('FF$hexColor', radix: 16));
    } catch (e) {
      return Colors.transparent;
    }
  }
}
