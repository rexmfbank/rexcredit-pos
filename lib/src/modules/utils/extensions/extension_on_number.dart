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

  /// Formats the number as a currency string with commas and 2 decimal places.
  /// Example: 15000.5 -> "15,000.50"
  String toCurrencyString() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(this);
  }

  /// Formats the number with comma separators and specified decimal places.
  /// Example: 15000.5.toCommaSeparatedWithDecimals() -> "15,000.50"
  /// Example: 15000.toCommaSeparatedWithDecimals(decimalDigits: 0) -> "15,000"
  String toCommaSeparatedWithDecimals({int decimalDigits = 2}) {
    final pattern =
        '#,##0${decimalDigits > 0 ? '.${'0' * decimalDigits}' : ''}';
    return NumberFormat(pattern, 'en_US').format(this);
  }
}

extension NumberExtensionNullable on num? {
  String toCommaSeparatedWithDecimals({int decimalDigits = 2}) {
    if (this == null) return '0.00';
    final pattern =
        '#,##0${decimalDigits > 0 ? '.${'0' * decimalDigits}' : ''}';
    return NumberFormat(pattern, 'en_US').format(this!);
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
