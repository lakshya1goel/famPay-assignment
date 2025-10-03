import 'package:flutter/material.dart';

class TextStyleUtils {
  TextStyleUtils._();

  static FontWeight getFontWeight(String? fontFamily) {
    if (fontFamily == null) return FontWeight.normal;

    final lowerFamily = fontFamily.toLowerCase();

    if (lowerFamily.contains('bold') && !lowerFamily.contains('semi')) {
      return FontWeight.bold;
    } else if (lowerFamily.contains('semi_bold') ||
        lowerFamily.contains('semibold')) {
      return FontWeight.w600;
    } else if (lowerFamily.contains('medium')) {
      return FontWeight.w500;
    } else if (lowerFamily.contains('light')) {
      return FontWeight.w300;
    }

    return FontWeight.normal;
  }

  static TextDecoration getTextDecoration(String? fontStyle) {
    if (fontStyle == null) return TextDecoration.none;

    final lowerStyle = fontStyle.toLowerCase();

    if (lowerStyle.contains('underline')) {
      return TextDecoration.underline;
    } else if (lowerStyle.contains('linethrough') ||
        lowerStyle.contains('line-through')) {
      return TextDecoration.lineThrough;
    } else if (lowerStyle.contains('overline')) {
      return TextDecoration.overline;
    }

    return TextDecoration.none;
  }

  static TextAlign getTextAlign(String? align) {
    if (align == null) return TextAlign.left;

    switch (align.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      case 'left':
      default:
        return TextAlign.left;
    }
  }

  static FontStyle getFontStyle(String? fontStyle) {
    if (fontStyle == null) return FontStyle.normal;

    if (fontStyle.toLowerCase().contains('italic')) {
      return FontStyle.italic;
    }

    return FontStyle.normal;
  }
}
