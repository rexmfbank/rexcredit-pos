import 'package:intl/intl.dart';

extension CurrencyFormatting on double {
  String toCurrencyString() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(this);
  }

  String toNairaAmountFormat() {
    final format = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2);
    return format.format(this);
  }
}