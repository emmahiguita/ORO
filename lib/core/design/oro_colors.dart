import 'package:flutter/material.dart';

abstract final class OroColors {
  // ── Water Liquid Glass Palette (2026 Premium Edition) ─────────────────────
  static const Color nightBlue = Color(0xFF071420);
  static const Color waterBlue = Color(0xFF0A7EA4);
  static const Color turquoise = Color(0xFF15C9CE);
  static const Color emerald = Color(0xFF1FA66A);
  static const Color crystalWhite = Color(0xFFF4FBFF);

  // ── Existing Tokens ───────────────────────────────────────────────────────
  static const Color ink = Color(0xFF101411);
  static const Color inkSoft = Color(0xFF1B211D);
  static const Color forest = Color(0xFF0C513A);
  static const Color forestLight = Color(0xFF1C7054);
  static const Color forestDark = Color(0xFF073827);
  static const Color forestSoft = Color(0xFFEAF3EE);

  static const Color accentGold = Color(0xFFB88931);
  static const Color accentGoldDark = Color(0xFF8D6821);
  static const Color accentGoldSoft = Color(0xFFF3E6C7);

  static const Color canvas = Color(0xFFF7F6F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F0EB);
  static const Color surfaceWarm = Color(0xFFFBF8F1);

  static const Color canvasDark = Color(0xFF071420);
  static const Color surfaceDark = Color(0xFF0C1D2B);
  static const Color surfaceDarkElevated = Color(0xFF122637);

  static const Color borderLight = Color(0xFFE4E3DD);
  static const Color dividerLight = Color(0xFFEAE9E4);
  static const Color borderDark = Color(0xFF1E3A52);
  static const Color dividerDark = Color(0xFF182E42);

  static const Color textPrimaryLight = Color(0xFF111411);
  static const Color textSecondaryLight = Color(0xFF626B65);
  static const Color textMutedLight = Color(0xFF8D958F);

  static const Color textPrimaryDark = Color(0xFFF4FBFF);
  static const Color textSecondaryDark = Color(0xFF94B5C6);
  static const Color textMutedDark = Color(0xFF6B8B9B);

  static const Color success = Color(0xFF1FA66A);
  static const Color error = Color(0xFFC84038);
  static const Color warning = Color(0xFFD78B24);
  static const Color info = Color(0xFF15C9CE);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient liquidGlassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xD9071420),
      Color(0x8C0A7EA4),
    ],
  );

  static const LinearGradient liquidGlassLightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xEDF4FBFF),
      Color(0xCCDAEEF5),
    ],
  );

  static const LinearGradient protectionGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.45, 1.0],
    colors: [
      Color(0x61071420), // ~0.38
      Color(0x2E071420), // ~0.18
      Color(0x52071420), // ~0.32
    ],
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, Color(0xFF158352)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [forestDark, forest, Color(0xFF173E30)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE6C779), accentGold],
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0C1D2B), Color(0xFF071420)],
  );
}
