import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: Appcolor.ink,
      onPrimary: Appcolor.surface,
      secondary: Appcolor.accentGold,
      onSecondary: Appcolor.ink,
      error: Appcolor.danger,
      onError: Appcolor.surface,
      surface: Appcolor.surface,
      onSurface: Appcolor.ink,
    );
    return _base(scheme, Appcolor.canvas);
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Appcolor.accentGold,
      onPrimary: Appcolor.ink,
      secondary: Color(0xFFE2C98F),
      onSecondary: Appcolor.ink,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: Color(0xFF151517),
      onSurface: Color(0xFFF3F0EB),
    );
    return _base(scheme, const Color(0xFF09090A));
  }

  static ThemeData _base(ColorScheme scheme, Color background) {
    final isDark = scheme.brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'Sw',
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontFamily: 'Sw',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Sw',
          fontSize: 44,
          height: 1.05,
          letterSpacing: -1.5,
          fontWeight: FontWeight.w800,
          color: scheme.onSurface,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Sw',
          fontSize: 30,
          height: 1.12,
          letterSpacing: -0.8,
          fontWeight: FontWeight.w800,
          color: scheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Sw',
          fontSize: 24,
          height: 1.16,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Sw',
          fontSize: 20,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Sw',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Sw',
          fontSize: 16,
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
          color: scheme.onSurface.withValues(alpha: .68),
        ),
        labelLarge: TextStyle(
          fontFamily: 'Sw',
          fontSize: 14,
          fontWeight: FontWeight.w700,
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
          fontWeight: FontWeight.w600,
          color: scheme.onSurface.withValues(alpha: .68),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1B1B1E) : Appcolor.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        hintStyle: TextStyle(
          color: scheme.onSurface.withValues(alpha: .48),
          fontWeight: FontWeight.w500,
        ),
        labelStyle: TextStyle(
          color: scheme.onSurface.withValues(alpha: .68),
          fontWeight: FontWeight.w600,
        ),
        prefixIconColor: scheme.onSurface.withValues(alpha: .66),
        suffixIconColor: scheme.onSurface.withValues(alpha: .66),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: scheme.onSurface.withValues(alpha: .10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: scheme.onSurface.withValues(alpha: .09),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.secondary, width: 1.4),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 54),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Sw',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 54),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.onSurface.withValues(alpha: .15)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 5,
        highlightElevation: 2,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: const CircleBorder(),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.onSurface.withValues(alpha: .08),
        space: 1,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
    );
  }
}
