import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/constants/string_regex.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

abstract class TextfieldValidator {
  /// validates the TextField that receives a name
  static String? name(String? value) {
    RegExp regExp = RegExp(StringRegex.personName);
    if (value == null || value.length < 2) {
      return StringAssets.textValidateShort;
    }
    if (value.isEmpty) {
      return StringAssets.textValidateEmpty;
    }
    if (!regExp.hasMatch(value)) {
      return StringAssets.textValidateName;
    }
    return null;
  }

  static String? businessName(String? value) {
    if (value == null || value.length < 2) {
      return StringAssets.textValidateShort;
    }
    if (value.isEmpty) {
      return StringAssets.textValidateEmpty;
    }

    return null;
  }

  /// validates the TextField that receives an input
  static String? input(String? value, [String? validationError]) {
    if (value == null || value.length < 3) {
      return validationError ?? StringAssets.textValidateShort;
    }
    if (value.isEmpty) {
      return StringAssets.textValidateEmpty;
    }
    return null;
  }

  /// validates the TextField that receives an input
  static String? integer(String? value) {
    if (value == null || value.isBlank) {
      return 'Field cannot be empty';
    }
    final numValue = int.tryParse(value) ?? 0;
    if (numValue < 0) {
      return 'Invalid value';
    }
    return null;
  }

  /// validates the TextField that receives a pin
  static String? pin(String? value) {
    if (value == null || (value.length < 4 || value.length > 6)) {
      return 'Invalid pin';
    }
    if (value.isEmpty) {
      return 'Pin cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives a pin
  static String? confirmPin({required String pin, String? value}) {
    if (value == null || (value.length < 4 || value.length > 6)) {
      return 'Invalid pin';
    }
    if (value.isEmpty) {
      return 'Pin cannot be empty';
    }

    if (value != pin) {
      return 'Pins do not match';
    }
    return null;
  }

  /// validates the OTP Field that receives an input
  static String? otpValidator(String? value, [int? length]) {
    if (value == null || value.length < (length ?? 4)) {
      return 'invalid OTP';
    }
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives a wallet number
  static String? walletNumber(String? value) {
    if (value == null || value.length != 10) {
      return 'invalid wallet number';
    }
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives a swift code
  static String? swiftCode(String? value) {
    if (value == null || value.length != 10) {
      return 'invalid SWIFT Code';
    }
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives a wallet number
  static String? cardNumber(String? value) {
    if (value == null || value.length != 16) {
      return 'invalid card number';
    }
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives a business registration number
  static String? businessRegistration(String? value) {
    if (value == null || value.length != 9) {
      return 'Invalid business registration number';
    }
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives a tax number
  static String? taxNumber(String? value) {
    if (value == null || value.length != 9) {
      return 'invalid tax number';
    }
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives the phone number
  static String? phoneNumber(String? value) {
    if (value.isNotBlank) {
      try {
        final phoneNumber = PhoneNumber.parse(
          value!,
          callerCountry: IsoCode.NG,
        );
        final isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
        if (!isValid) return "Phone number is invalid";
      } catch (e) {
        return "Phone number is invalid";
      }
    }

    if (value == null || value.isEmpty) {
      return 'Invalid: phone number cannot be empty';
    }
    return null;
  }

  /// validates the TextField that receives the email
  static String? email(String? value) {
    if (value != null) {
      final isValid = RegExp(StringRegex.email).hasMatch(value);
      if (!isValid) return StringAssets.invalidEmail;
    }
    return null;
  }

  /// validates the TextField that receives the password
  static String? password(String? value) {
    if (value != null) {
      final upperCase = RegExp(StringRegex.passUpperCase).hasMatch(value);
      final lowerCase = RegExp(StringRegex.passLowerCase).hasMatch(value);
      final symbol = RegExp(StringRegex.passSymbol).hasMatch(value);
      final digits = RegExp(StringRegex.passNumber).hasMatch(value);
      final min8char = RegExp(StringRegex.pass8Chars).hasMatch(value);

      if (!digits) return 'Must have a number';
      if (!upperCase) return 'Must have an upper case letter';
      if (!lowerCase) return 'Must have a lower case letter';
      if (!symbol) return 'Must have a symbol';
      if (!min8char) return 'Must have at least 8 characters';
    }
    return null;
  }

  /// validates the TextField that receives the password and ensures it matches the comparison
  static String? confirmPassword({required String password, String? value}) {
    if (value != null) {
      final upperCase = RegExp(StringRegex.passUpperCase).hasMatch(value);
      final lowerCase = RegExp(StringRegex.passLowerCase).hasMatch(value);
      final symbol = RegExp(StringRegex.passSymbol).hasMatch(value);
      final digits = RegExp(StringRegex.passNumber).hasMatch(value);
      final min8char = RegExp(StringRegex.pass8Chars).hasMatch(value);

      if (!upperCase) return 'Must have an upper case letter';
      if (!lowerCase) return 'Must have a lower case letter';
      if (!symbol) return 'Must have a symbol';
      if (!digits) return 'Must have a number';
      if (!min8char) return 'Must have at least 8 characters';

      if (value != password) {
        return 'Passwords do not match';
      }
    }

    return null;
  }

  /// validates the TextField that receives the amount
  static String? amount(String? value) {
    final amountValue = value?.replaceAll(',', '');
    if (amountValue != null) {
      if (amountValue.isBlank) {
        return StringAssets.invalidAmount;
      }

      final doubleAmount = num.tryParse(amountValue) ?? 0.00;
      if (doubleAmount < 5.00) {
        return StringAssets.transactionAmountShouldNotBeLess("5");
      }
    }
    return null;
  }

  /// validates the TextField that receives the amount with a dynamic set minimum Amount
  static String? minAmount({String? value, required double minAmount}) {
    final amountValue = value?.replaceAll(',', '');
    if (amountValue != null) {
      if (amountValue.isBlank) {
        return StringAssets.invalidAmount;
      }

      final doubleAmount = num.tryParse(amountValue) ?? 0.00;
      if (doubleAmount < minAmount) {
        return StringAssets.transactionAmountShouldNotBeLess(
            minAmount.toString());
      }
    }
    return null;
  }

  /// validates the TextField that receives the loan Amount with minimum and maximum amount values
  static String? loanAmount(String? value, num maxAmount, num minAmount) {
    if (value != null) {
      if (value.isBlank) {
        return StringAssets.invalidAmount;
      }

      final numValue = num.tryParse(value) ?? 0.00;
      if (minAmount > numValue) {
        return StringAssets.loanAmountShouldNotBeLess(minAmount.toString());
      }
      if (numValue > maxAmount) {
        return StringAssets.loanAmountShouldNotBeMore(maxAmount.toString());
      }
    }
    return null;
  }

  /// validates TextField for savings amount
  static String? savingsAmount(String? value) {
    if (value != null) {
      if (value.isBlank) return StringAssets.invalidAmount;
      final amount = num.tryParse(value) ?? 0.0;
      if (amount < 1000.00) return StringAssets.savingsAmount;
      if (amount.isNegative) return StringAssets.negativeAmount;
    }
    return null;
  }

  /// validates TextField for savings amount
  static String? savingsAmount2(String? value) {
    final input = value?.replaceAll(',', '');
    if (input != null) {
      if (input.isBlank) return StringAssets.invalidAmount;
      final amount = num.tryParse(input) ?? 0.00;
      if (amount < 1000.00) return StringAssets.savingsAmount;
      if (amount.isNegative) return StringAssets.negativeAmount;
    }
    return null;
  }

  /// validates TextField
  static String? checkAmountInput(String? value, double minimum) {
    final input = value?.replaceAll(',', '');
    if (input != null) {
      if (input.isBlank) return StringAssets.invalidAmount;
      final amount = num.tryParse(input) ?? 0.00;
      if (amount < minimum) {
        return "Amount can not be less than ${minimum.formatCurrencyNum()}";
      }
      if (amount.isNegative) return StringAssets.negativeAmount;
    }
    return null;
  }

  static String? topupAmount(String? value) {
    final input = value?.replaceAll(',', '');
    if (input != null) {
      if (input.isBlank) return StringAssets.invalidAmount;
      final amount = num.tryParse(input) ?? 0.00;
      if (amount.isNegative) return StringAssets.negativeAmount;
    }
    return null;
  }

  /// validates TextField for fixed deposit amount
  static String? depositAmount(String? value) {
    if (value != null) {
      if (value.isBlank) return StringAssets.invalidAmount;
      final amount = num.tryParse(value) ?? 0.0;
      if (amount < 100.00) return StringAssets.depositAmount;
      if (amount.isNegative) return StringAssets.negativeAmount;
    }
    return null;
  }

  static String? depositAmount2(String? value) {
    final input = value?.replaceAll(',', '');
    if (input != null) {
      if (input.isBlank) return StringAssets.invalidAmount;
      final amount = num.tryParse(input) ?? 0.0;
      if (amount < 100.00) return StringAssets.depositAmount;
      if (amount.isNegative) return StringAssets.negativeAmount;
    }
    return null;
  }

  /// validates the TextField that receives an input
  static String? bvn(String? value) {
    if (value == null || value.length != 11) return StringAssets.invalidBvn;
    if (value.isEmpty) StringAssets.noEmptyField;
    return null;
  }

  static String? nin(String? value) {
    if (value == null || value.length != 11) return StringAssets.invalidNin;
    if (value.isEmpty) return StringAssets.noEmptyField;
    return null;
  }

  /// validates the TextField that receives the smartCardNo
  static String? smartCardNo(String? value) {
    if (value != null) {
      if (value.isBlank || value.length < 10) {
        return StringAssets.invalidSmartCardNo;
      }
    }
    return null;
  }

  /// validates the TextField that receives the smartCardNo
  static String? accountNo(String? value) {
    if (value != null) {
      if (value.isBlank || value.length != 10) {
        return StringAssets.invalidAccountNo;
      }
    }
    return null;
  }

  /// checks transaction pin for valid combinations of digits.
  /// if a cobination is weak, it returns false
  static bool validatePIN(String pin) {
    if (pin.contains('1234') ||
        pin.contains('5678') ||
        pin.contains('111') ||
        pin.contains('0123') ||
        pin.contains('222')) {
      return false;
    }

    List<int> lens = List.filled(pin.length, 0);

    for (int i = 0; i < pin.length; i++) {
      for (int j = 0; j < pin.length; j++) {
        if (pin[i] == pin[j] && i != j) {
          lens[i]++;
        }
      }
    }
    for (int i = 0; i < pin.length; i++) {
      if (lens[i] >= 2) {
        return false;
      }
    }
    return true;
  }

  /// validates the TextField that receives the meterNo
  static String? meterNo(String? value) {
    if (value != null) {
      if (value.isBlank || value.length < 8) {
        return StringAssets.invalidMeterNo;
      }
    }
    return null;
  }
}
