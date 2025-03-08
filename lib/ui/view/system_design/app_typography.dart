import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static boldTextView(double fontSize, Color color) {
    return TextStyle(
      fontFamily: 'sfBold',
      fontSize: fontSize,
      color: color,
    );
  }

  static mediumTextView(double fontSize, Color color, bool isComplete) {
    return TextStyle(
        fontFamily: 'sfMedium',
        fontSize: fontSize,
        color: isComplete ? color.withOpacity(0.3) : color,
        decoration:
            isComplete ? TextDecoration.lineThrough : TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid,
        decorationColor: isComplete ? color.withOpacity(0.3) : color);
  }

  static regularTextView(double fontSize, Color color) {
    return TextStyle(
      fontFamily: 'sfRegular',
      fontSize: fontSize,
      color: color,
    );
  }
}
