import 'package:intl/intl.dart';

extension NumberExtension on num {
  String formatCurrencyNum() {
    final formattedString = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 2,
    ).format(this);
    return "\u20A6$formattedString";
  }

  String to2dp() {
    return toStringAsFixed(2);
  }
}

extension CurrencyFormatting on double {
  String toCurrencyString() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(this);
  }

  String to2dp() {
    return toStringAsFixed(2);
  }
}
