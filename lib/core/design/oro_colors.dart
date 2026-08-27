import 'package:flutter/material.dart';

abstract final class OroColors {
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

  static const Color canvasDark = Color(0xFF0B0F0D);
  static const Color surfaceDark = Color(0xFF111713);
  static const Color surfaceDarkElevated = Color(0xFF18211C);

  static const Color borderLight = Color(0xFFE4E3DD);
  static const Color dividerLight = Color(0xFFEAE9E4);
  static const Color borderDark = Color(0xFF2B3831);
  static const Color dividerDark = Color(0xFF243129);

  static const Color textPrimaryLight = Color(0xFF111411);
  static const Color textSecondaryLight = Color(0xFF626B65);
  static const Color textMutedLight = Color(0xFF8D958F);

  static const Color textPrimaryDark = Color(0xFFF6F7F4);
  static const Color textSecondaryDark = Color(0xFFB2BCB5);
  static const Color textMutedDark = Color(0xFF7E8A82);

  static const Color success = Color(0xFF267052);
  static const Color error = Color(0xFFC84038);
  static const Color warning = Color(0xFFD78B24);
  static const Color info = Color(0xFF376C9E);

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
    colors: [Color(0xFF1A2520), Color(0xFF101714)],
  );
}
