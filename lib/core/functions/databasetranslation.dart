import 'package:get/get.dart';
import 'package:oro/core/services/services.dart';

/// Selecciona el campo traducido de la base de datos.
/// Español es el fallback principal; si un registro aún no tiene traducción ES,
/// se muestra inglés para evitar textos vacíos.
String databaseTranslation(dynamic en, dynamic ar, dynamic es) {
  final langcode = Get.isRegistered<Services>()
      ? (Get.find<Services>().sharedPreferences.getString('langcode') ?? 'es')
      : 'es';
  final english = (en ?? '').toString();
  final arabic = (ar ?? '').toString();
  final spanish = (es ?? '').toString();

  if (langcode == 'ar') return arabic.trim().isNotEmpty ? arabic : english;
  if (langcode == 'en') return english.trim().isNotEmpty ? english : spanish;
  return spanish.trim().isNotEmpty ? spanish : english;
}
