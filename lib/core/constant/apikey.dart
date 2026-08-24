class ApiKeys {
  ApiKeys._();

  /// Se inyecta en ejecución con:
  /// --dart-define=GOOGLE_MAPS_API_KEY=tu_clave
  static const String gMap = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: '',
  );
}
