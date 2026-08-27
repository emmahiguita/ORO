import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class OroMotion {
  static const fast = Duration(milliseconds: 140);
  static const medium = Duration(milliseconds: 220);
  static const slow = Duration(milliseconds: 340);
  static const page = Duration(milliseconds: 420);
  static const hero = Duration(milliseconds: 520);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve decelerate = Curves.easeOutQuart;

  static bool reduced(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context);

  static bool reduceMotion(BuildContext context) => reduced(context);

  static Duration adaptive(BuildContext context, Duration duration) =>
      reduced(context) ? Duration.zero : duration;

  static Future<void> selectionHaptic() async {
    await HapticFeedback.selectionClick();
  }

  static Future<void> successHaptic() async {
    await HapticFeedback.lightImpact();
  }
}
