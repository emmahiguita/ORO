import 'package:jiffy/jiffy.dart';

/// Safely formats any date object or string to a human-friendly relative format (e.g. "2 hours ago").
/// Never throws an exception on null or invalid dates.
String formatRelativeDate(dynamic value, {String fallback = ''}) {
  if (value == null) return fallback;
  final str = value.toString().trim();
  if (str.isEmpty || str == 'null') return fallback;

  try {
    return Jiffy.parse(str).fromNow();
  } catch (_) {
    try {
      final dt = DateTime.tryParse(str);
      if (dt != null) {
        return Jiffy.parseFromDateTime(dt).fromNow();
      }
    } catch (_) {}
    return fallback.isNotEmpty ? fallback : str;
  }
}

/// Safely formats any date object or string with a pattern.
/// Never throws an exception on null or invalid dates.
String formatDisplayDate(dynamic value,
    {String pattern = 'MMM dd, yyyy', String fallback = ''}) {
  if (value == null) return fallback;
  final str = value.toString().trim();
  if (str.isEmpty || str == 'null') return fallback;

  try {
    return Jiffy.parse(str).format(pattern: pattern);
  } catch (_) {
    try {
      final dt = DateTime.tryParse(str);
      if (dt != null) {
        return Jiffy.parseFromDateTime(dt).format(pattern: pattern);
      }
    } catch (_) {}
    return fallback.isNotEmpty ? fallback : str;
  }
}
