import 'package:flutter/material.dart';

// size of height and width of screen
extension ScreenSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}