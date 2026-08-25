import 'package:flutter/material.dart';

/// Semantic Motion System for ORO 2026.
/// Respects accessibility reduceMotion / disableAnimationsOf settings.
abstract final class OroMotion {
  static const Duration instant = Duration(milliseconds: 90);
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration medium = Duration(milliseconds: 240);
  static const Duration slow = Duration(milliseconds: 360);
  static const Duration page = Duration(milliseconds: 420);
  static const Duration hero = Duration(milliseconds: 520);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve decelerate = Curves.easeOutQuart;
  static const Curve spring = Curves.elasticOut;

  /// Returns true if animations should be disabled for accessibility.
  static bool reduceMotion(BuildContext context) {
    return MediaQuery.disableAnimationsOf(context);
  }

  /// Returns [Duration.zero] if reduce motion is requested, else [duration].
  static Duration adaptive(BuildContext context, Duration duration) {
    return reduceMotion(context) ? Duration.zero : duration;
  }
}
