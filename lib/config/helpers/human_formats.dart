import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [ int decimals = 0 ]) {
    final formattedNumber = NumberFormat.compactCurrency(
      locale: 'en',
      symbol: '',
      decimalDigits: decimals,
    );

    return formattedNumber.format(number);
  }
}
