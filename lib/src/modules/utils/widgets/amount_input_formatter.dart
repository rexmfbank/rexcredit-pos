import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numericValue = int.tryParse(newValue.text.replaceAll(',', ''));

    if (numericValue != null) {
      final commaFormattedValue = NumberFormat('#,##0').format(numericValue);

      return newValue.copyWith(
        text: commaFormattedValue,
        selection: TextSelection.collapsed(offset: commaFormattedValue.length),
      );
    }

    return newValue;
  }
}
