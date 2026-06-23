import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/constants/string_regex.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

abstract class AppTextValidator {
  static String? businessName(String? value) {
    if (value == null || value.length < 2) {
      return Strings.textValidateShort;
    }
    if (value.isEmpty) {
      return Strings.textValidateEmpty;
    }

    return null;
  }

  static String? name(String? value) {
    RegExp regExp = RegExp(StringRegex.personName);
    if (value == null || value.length < 2) {
      return Strings.textValidateShort;
    }
    if (value.isEmpty) {
      return Strings.textValidateEmpty;
    }
    if (!regExp.hasMatch(value)) {
      return Strings.textValidateName;
    }
    return null;
  }

  /// validates the TextField that receives an input
  static String? input(String? value, [String? validationError]) {
    if (value == null || value.length < 3) {
      return validationError ?? Strings.textValidateShort;
    }
    if (value.isEmpty) {
      return Strings.textValidateEmpty;
    }
    return null;
  }

  static String? walletNumber(String? value) {
    if (value == null || value.length != 10) {
      return 'invalid wallet number';
    }
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  static String? minAmount({String? value, required double minAmount}) {
    final amountValue = value?.replaceAll(',', '');
    if (amountValue != null) {
      if (amountValue.isBlank) {
        return Strings.invalidAmount;
      }

      final doubleAmount = num.tryParse(amountValue) ?? 0.00;
      if (doubleAmount < minAmount) {
        return Strings.transactionAmountShouldNotBeLess(minAmount.toString());
      }
    }
    return null;
  }
}
