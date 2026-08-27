import 'package:flutter/material.dart';

abstract final class OroSpace {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
}

abstract final class OroRadius {
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double hero = 28;
  static const double pill = 999;
}

abstract final class OroSize {
  static const double minTouch = 48;
  static const double icon = 22;
  static const double navHeight = 72;
  static const double pageHorizontal = 20;
}

abstract final class OroBreakpointsV2 {
  static const double medium = 600;
  static const double expanded = 840;
  static const double large = 1200;

  static int productColumns(double width) {
    if (width >= large) return 5;
    if (width >= expanded) return 4;
    if (width >= medium) return 3;
    return 2;
  }
}

extension OroContextX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}
