import 'package:intl/intl.dart';

abstract final class OroMoney {
  static String format(num? value, {String symbol = r'$', bool withCurrencyCode = false}) {
    final amount = value?.toDouble() ?? 0;
    // Formato estándar colombiano con puntos de miles: 140.600.000
    final numFormat = NumberFormat('#,##0', 'es_CO');
    final formattedDigits = numFormat.format(amount.round()).replaceAll(',', '.');

    final prefix = symbol.isNotEmpty ? '$symbol ' : '';
    final suffix = withCurrencyCode ? ' COP' : '';
    return '$prefix$formattedDigits$suffix';
  }
}

