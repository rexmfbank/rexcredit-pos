import 'package:intl/intl.dart';

extension DoubleExt on double {
  String toCurrencyString() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(this);
  }

  String toNairaAmountFormat() {
    final format = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 2,
    );
    return format.format(this);
  }
}

extension NullableDoubleExt on double? {
  /// Formats a nullable double as 1,234,567 (no symbol, no decimals).
  /// Returns 'n/a' when the value is null.
  String toCurrencyNoSymbol() {
    if (this == null) return 'n/a';
    // Convert to whole-number text (strip decimals if you don’t need them).
    final plain = this!.toStringAsFixed(0);
    // Insert commas every three digits from the right.
    return plain.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  String toCommaSeparatedWithDecimals({
    int decimalDigits = 2,
    String defaultValue = '0.00',
  }) {
    if (this == null) return defaultValue;
    final pattern =
        '#,##0${decimalDigits > 0 ? '.${'0' * decimalDigits}' : ''}';
    return NumberFormat(pattern, 'en_US').format(this!);
  }
}
