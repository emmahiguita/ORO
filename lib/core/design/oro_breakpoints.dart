/// Breakpoints and responsive helpers for ORO 2026 adaptive layouts.
abstract final class OroBreakpoints {
  static const double compact = 360;
  static const double medium = 600;
  static const double expanded = 840;
  static const double large = 1200;

  /// Returns the optimal number of grid columns based on available cross-axis width.
  static int gridColumns(double width) {
    if (width >= large) return 5;
    if (width >= expanded) return 4;
    if (width >= medium) return 3;
    return 2;
  }

  /// Returns optimal child aspect ratio for product cards on different screen sizes.
  static double productAspectRatio(double width) {
    if (width >= large) return 1.18;
    if (width >= expanded) return 1.12;
    if (width >= medium) return 1.08;
    return 1.02;
  }

  /// Returns optimal horizontal container padding.
  static double horizontalPadding(double width) {
    if (width >= large) return 32.0;
    if (width >= medium) return 24.0;
    return 16.0;
  }
}
