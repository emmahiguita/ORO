import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: OroColors.forest,
      onPrimary: Colors.white,
      primaryContainer: OroColors.forestSoft,
      onPrimaryContainer: OroColors.forestDark,
      secondary: OroColors.accentGold,
      onSecondary: OroColors.ink,
      secondaryContainer: OroColors.accentGoldSoft,
      onSecondaryContainer: OroColors.accentGoldDark,
      error: OroColors.error,
      onError: Colors.white,
      surface: OroColors.surface,
      onSurface: OroColors.textPrimaryLight,
      surfaceContainerHighest: OroColors.surfaceMuted,
      outline: OroColors.borderLight,
      outlineVariant: OroColors.dividerLight,
    );
    return _base(scheme, OroColors.canvas);
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: OroColors.accentGold,
      onPrimary: OroColors.ink,
      primaryContainer: OroColors.forestDark,
      onPrimaryContainer: OroColors.accentGoldSoft,
      secondary: OroColors.accentGoldSoft,
      onSecondary: OroColors.ink,
      secondaryContainer: Color(0xFF352A14),
      onSecondaryContainer: OroColors.accentGoldSoft,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: OroColors.surfaceDark,
      onSurface: OroColors.textPrimaryDark,
      surfaceContainerHighest: OroColors.surfaceDarkElevated,
      outline: OroColors.borderDark,
      outlineVariant: OroColors.dividerDark,
    );
    return _base(scheme, OroColors.canvasDark);
  }

  static ThemeData _base(ColorScheme scheme, Color scaffold) {
    final isDark = scheme.brightness == Brightness.dark;

    final text = TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Sw',
        fontSize: 30,
        height: 1.08,
        letterSpacing: -.8,
        fontWeight: FontWeight.w800,
        color: scheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Sw',
        fontSize: 24,
        height: 1.12,
        letterSpacing: -.5,
        fontWeight: FontWeight.w800,
        color: scheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Sw',
        fontSize: 20,
        height: 1.18,
        letterSpacing: -.3,
        fontWeight: FontWeight.w800,
        color: scheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Sw',
        fontSize: 18,
        height: 1.2,
        letterSpacing: -.25,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Sw',
        fontSize: 16,
        height: 1.25,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Sw',
        fontSize: 14,
        height: 1.25,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Sw',
        fontSize: 16,
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Sw',
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Sw',
        fontSize: 12,
        height: 1.35,
        fontWeight: FontWeight.w500,
        color:
            isDark ? OroColors.textSecondaryDark : OroColors.textSecondaryLight,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Sw',
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: scheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Sw',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Sw',
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: isDark ? OroColors.textMutedDark : OroColors.textMutedLight,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      fontFamily: 'Sw',
      textTheme: text,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? OroColors.surfaceDarkElevated : OroColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        hintStyle: text.bodyMedium?.copyWith(
          color: isDark ? OroColors.textMutedDark : OroColors.textMutedLight,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 54),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 54),
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: text.labelLarge,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 7,
        highlightElevation: 3,
        backgroundColor: OroColors.forest,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
