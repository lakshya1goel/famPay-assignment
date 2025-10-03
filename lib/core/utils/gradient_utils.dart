import 'dart:math' as math;
import 'package:flutter/material.dart';

class GradientUtils {
  GradientUtils._();

  static AlignmentGeometry getGradientAlignment(int angle, bool isBegin) {
    final radians = (angle - 90) * math.pi / 180;

    if (isBegin) {
      return Alignment(-math.cos(radians), -math.sin(radians));
    } else {
      return Alignment(math.cos(radians), math.sin(radians));
    }
  }

  static LinearGradient createLinearGradient({
    required List<String> colors,
    required int angle,
    required Color Function(String?) colorParser,
  }) {
    return LinearGradient(
      colors: colors.map((color) => colorParser(color)).toList(),
      begin: getGradientAlignment(angle, true),
      end: getGradientAlignment(angle, false),
    );
  }
}
