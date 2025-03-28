import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

getNairaCurrency(context) {
  Locale locale = Localizations.localeOf(context);

  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format;
}

String addNairaCurrencySymbol(String value) {
  const currencySymbol = '₦';
  return '$currencySymbol$value';
}

String addCurrencySymbol(String value, String currency) {
  return '$currency$value';
}
