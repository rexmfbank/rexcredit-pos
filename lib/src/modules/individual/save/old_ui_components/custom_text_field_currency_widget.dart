import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/currency.dart';

class RexTextFieldCurrencyWidget extends StatelessWidget {
  const RexTextFieldCurrencyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15, right: 0),
      child: Text('${getNairaCurrency(context).currencySymbol}'),
    );
  }
}
