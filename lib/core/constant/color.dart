import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

/// Paleta editorial premium 2026.
///
/// Los aliases antiguos se conservan para no romper widgets existentes mientras
/// la aplicación migra gradualmente al nuevo sistema visual OroColors.
class Appcolor {
  // --- Design tokens principales ---
  static const Color ink = OroColors.ink;
  static const Color inkSoft = OroColors.inkSoft;
  static const Color canvas = OroColors.canvas;
  static const Color surface = OroColors.surface;
  static const Color surfaceDark = OroColors.surfaceDark;
  static const Color surfaceWarm = Color(0xFFF0ECE6);
  static const Color stone = Color(0xFF817B73);
  static const Color stoneLight = Color(0xFFD9D4CD);
  static const Color accentGold = OroColors.accentGold;
  static const Color accentGoldSoft = OroColors.accentGoldSoft;
  static const Color oxblood = Color(0xFF6C2735);
  static const Color forest = OroColors.forest;
  static const Color forestLight = OroColors.forestLight;
  static const Color navy = Color(0xFF26364A);
  static const Color camel = Color(0xFF9A7048);
  static const Color plum = Color(0xFF60415E);
  static const Color clay = Color(0xFFA4604D);
  static const Color sage = Color(0xFF71806A);
  static const Color bronze = Color(0xFF806448);
  static const Color success = OroColors.success;
  static const Color danger = OroColors.error;

  // --- Compatibilidad con el código original ---
  static const Color rosePompadour = accentGold;
  static const Color amaranthpink = ink;
  static const Color mimiPink = accentGoldSoft;
  static const Color beige = canvas;
  static const Color lightblue = stoneLight;
  static const Color deepcyan = stone;
  static const Color white = surface;
  static const Color black = ink;
  static const Color shadow = Color(0x22000000);
  static const Color grey = inkSoft;
  static const Color hotPink = oxblood;
  static const Color pink = clay;
  static const Color purple = plum;
  static const Color deepPurple = Color(0xFF4E425D);
  static const Color indigo = navy;
  static const Color blue = Color(0xFF48647D);
  static const Color cyan = Color(0xFF5C7E83);
  static const Color teal = forest;
  static const Color green = success;
  static const Color lightGreen = sage;
  static const Color deepOrange = clay;
  static const Color amber = camel;
  static const Color yellow = accentGold;
  static const Color brown = bronze;
  static const Color greyShade = stone;
  static const Color charcoalGray = inkSoft;
  static const Color indigoBlue = navy;
  static const Color skyBlue = Color(0xFF5E7891);
  static const Color blueGray = Color(0xFF66727A);
  static const Color deepPink = oxblood;
  static const Color shadowPink = Color(0x1FC89B3C);
  static const Color whitePink = canvas;
  static const Color lightPink = surfaceWarm;
  static const Color berry = oxblood;
  static const Color blackShadow = Color(0x1A000000);
  static const Color shadowWhite = Color(0x4DFFFFFF);
  static const Color dustyPink = surfaceWarm;
  static const Color red = danger;
  static const Color textColor = ink;
  static const Color deepRed = oxblood;
  static const Color lightRed = Colors.red;
}
