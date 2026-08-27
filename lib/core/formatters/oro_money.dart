import 'package:intl/intl.dart';

abstract final class OroMoney {
  static String format(num? value, {String symbol = r'$'}) {
    final amount = value?.toDouble() ?? 0;
    final decimals = amount == amount.roundToDouble() ? 0 : 2;

    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: symbol,
      decimalDigits: decimals,
    );

    return formatter.format(amount).replaceAll('\u00A0', ' ');
  }
}
