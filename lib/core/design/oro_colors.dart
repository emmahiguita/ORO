import 'package:flutter/material.dart';

/// Semantic color design tokens for ORO 2026 design system.
abstract final class OroColors {
  // Brand Core
  static const Color ink = Color(0xFF07120E);
  static const Color inkSoft = Color(0xFF0D1B15);
  static const Color canvas = Color(0xFFF7F5EF);
  static const Color surface = Color(0xFFFFFDF8);
  static const Color surfaceDark = Color(0xFF131D18);
  static const Color surfaceDarkElevated = Color(0xFF1B2822);

  static const Color forest = Color(0xFF0B4D36);
  static const Color forestLight = Color(0xFF146C4D);
  static const Color forestDark = Color(0xFF063323);

  static const Color accentGold = Color(0xFFC89B3C);
  static const Color accentGoldSoft = Color(0xFFF1DCA9);
  static const Color accentGoldDark = Color(0xFF9E7728);

  // Neutral & Borders
  static const Color borderLight = Color(0xFFE6E2D8);
  static const Color borderDark = Color(0xFF24352D);
  static const Color dividerLight = Color(0xFFEBE8DF);
  static const Color dividerDark = Color(0xFF1E2D26);

  // Typography
  static const Color textPrimaryLight = Color(0xFF07120E);
  static const Color textSecondaryLight = Color(0xFF626E67);
  static const Color textMutedLight = Color(0xFF8E9A93);

  static const Color textPrimaryDark = Color(0xFFF7F5EF);
  static const Color textSecondaryDark = Color(0xFF9BA69F);
  static const Color textMutedDark = Color(0xFF6B7770);

  // States
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFED6C02);
  static const Color info = Color(0xFF0288D1);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [forest, forestLight],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGoldSoft, accentGold],
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2620), Color(0xFF101915)],
  );
}
