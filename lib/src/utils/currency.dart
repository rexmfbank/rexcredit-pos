import 'dart:io';

import 'package:intl/intl.dart';

getNairaCurrency(context) {
  var format = NumberFormat.simpleCurrency(
    locale: Platform.localeName,
    name: 'NGN',
  );
  return format;
}

String addNairaCurrencySymbol(String value) {
  const currencySymbol = '₦';
  return '$currencySymbol$value';
}

String addCurrencySymbol(String value, String currency) {
  return '$currency$value';
}
