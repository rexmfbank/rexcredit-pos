import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RexTextFieldCurrencyIcon extends StatelessWidget {
  const RexTextFieldCurrencyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text('${getNairaCurrency(context).currencySymbol}'),
    );
  }
}

getNairaCurrency(context) {
  var format = NumberFormat.simpleCurrency(
    locale: Platform.localeName,
    name: 'NGN',
  );
  return format;
}
