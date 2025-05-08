import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      locale: 'en',
      symbol: '',
      decimalDigits: 0,
    );

    return formattedNumber.format(number);
  }
}
