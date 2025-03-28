import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String currencySymbol;
  final int maxNumberOfDecimalPlaces;

  CurrencyInputFormatter({
    required this.currencySymbol,
    this.maxNumberOfDecimalPlaces = 2,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newInputString = newValue.text;
    bool isParsableString = false;

    try {
      NumberFormat().parse(newInputString);
      isParsableString = true;
    } catch (e) {
      isParsableString = false;
    }

    if (newInputString.length < currencySymbol.length && !isParsableString) {
      return TextEditingValue(
        text: currencySymbol,
        selection: TextSelection.collapsed(offset: currencySymbol.length),
      );
    }

    if (newInputString == currencySymbol) {
      return TextEditingValue(
        text: newInputString,
        selection: TextSelection.collapsed(offset: currencySymbol.length),
      );
    }

    String numberWithoutGroupingSeparator = newInputString.replaceAll(',', '');
    if (numberWithoutGroupingSeparator == NumberFormat().symbols.DECIMAL_SEP) {
      numberWithoutGroupingSeparator = '0${NumberFormat().symbols.DECIMAL_SEP}';
    }

    numberWithoutGroupingSeparator = truncateNumberToMaxDecimalDigits(
      numberWithoutGroupingSeparator,
      maxNumberOfDecimalPlaces,
      NumberFormat().symbols.DECIMAL_SEP,
    );

    NumberFormat fractionDecimalFormat = NumberFormat();
    var parsedNumber =
        fractionDecimalFormat.parse(numberWithoutGroupingSeparator);

    if (newInputString.contains(NumberFormat().symbols.DECIMAL_SEP)) {
      fractionDecimalFormat = NumberFormat.currency(
        decimalDigits: maxNumberOfDecimalPlaces,
        symbol: '',
      );
      newInputString =
          '$currencySymbol${fractionDecimalFormat.format(parsedNumber)}';
    } else {
      var wholeNumberDecimalFormat = NumberFormat.currency(
        decimalDigits: 0,
        symbol: '',
      );
      newInputString =
          '$currencySymbol${wholeNumberDecimalFormat.format(parsedNumber)}';
    }

    return TextEditingValue(
      text: newInputString,
      selection: TextSelection.collapsed(offset: newInputString.length),
    );
  }

  String truncateNumberToMaxDecimalDigits(
    String number,
    int maxDecimalDigits,
    String decimalSeparator,
  ) {
    int noOfCharactersAfterDecimalPoint =
        number.length - number.indexOf(decimalSeparator) - 1;
    int truncateLength = min(noOfCharactersAfterDecimalPoint, maxDecimalDigits);
    return number.substring(0, number.length - truncateLength);
  }
}
