abstract final class JsonParser {
  static int? asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();

    final str = value.toString().trim();
    if (str.isEmpty) return null;

    final parsed = int.tryParse(str);
    if (parsed != null) return parsed;

    // Si viene como decimal en string ("149.99"), convertimos a double primero y truncamos a int si corresponde
    final parsedDouble = double.tryParse(str.replaceAll(',', '.'));
    return parsedDouble?.toInt();
  }

  static double? asDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is num) return value.toDouble();

    final str = value.toString().trim();
    if (str.isEmpty) return null;

    final normalized = str.replaceAll(',', '.');
    return double.tryParse(normalized);
  }

  static String? asString(dynamic value) {
    if (value == null) return null;
    final result = value.toString().trim();
    return result.isEmpty ? null : result;
  }

  static bool asBool(
    dynamic value, {
    bool fallback = false,
  }) {
    if (value == null) return fallback;
    if (value is bool) return value;

    switch (value.toString().trim().toLowerCase()) {
      case '1':
      case 'true':
      case 'yes':
        return true;
      case '0':
      case 'false':
      case 'no':
        return false;
      default:
        return fallback;
    }
  }
}
