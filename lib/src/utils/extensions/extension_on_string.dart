import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  /// 070 34 34 34 34
  /// 080 34 34 34 34
  /// 090 34 34 34 34
  bool validatePhoneNumber() {
    Set<String> initials = {'070', '080', '090'};
    if (length != 11) {
      return false;
    }
    if (!initials.contains(substring(0, 3))) {
      return false;
    }
    return true;
  }

  String getDepositDuration() {
    final a1 = split(' ');
    final firstPart = a1[0];
    // final int1 = int.parse(firstPart);
    return firstPart;
  }

  String monthString() {
    final splitt = split(' ');
    final string1 = splitt[0];

    final parse1 = int.parse(string1);
    final div1 = parse1 ~/ 30;
    return '$div1 months';
  }

  String formatCurrencyString() {
    final formatedString = replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return "\u20A6$formatedString";
  }

  String formatCurrencyStringNoSymbol() {
    final formatedString = replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return formatedString;
  }

  String toNairaAmountFormat() {
    final num? value = num.tryParse(this);
    if (value == null) {
      return this; // Return original string if not a valid number
    }

    final format = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 2,
    );
    return format.format(value);
  }

  String formatWhatsAppDigit() {
    final sub = substring(1);
    const ngPrefix = '234';
    return "$ngPrefix$sub";
  }

  String? formatPhoneNumber() {
    if (startsWith('234') && length == 13) {
      return '+234 ${substring(3, 6)} ${substring(6, 9)} ${substring(9, 13)}';
    }
    return this;
  }

  String capitalizeEachWord() {
    return split(" ")
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(" ");
  }

  String capitalizeEachWordv2() {
    return replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }

  String truncate(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return "${substring(0, maxLength)}...";
    }
  }

  /// Formats a datetime string from "YYYY-MM-DD HH:mm:ss.SSS"
  /// to "Mon DD, YYYY HH:mm".
  /// Example:
  /// "2025-07-03 07:27:42.0".toFormattedDateTime();
  /// Returns "Jul 3, 2025 07:27"
  String toPosTime() {
    try {
      final dateTime = DateTime.parse(this);
      final formatter = DateFormat('MMM d, yyyy HH:mm');
      return formatter.format(dateTime);
    } catch (e) {
      print('Error parsing date string: $this - $e');
      return 'N/A';
    }
  }

  // Method to check if the string contains any uppercase letters
  bool containsUppercase() {
    return contains(RegExp(r'[A-Z]'));
    // contains(RegExp(r'[A-Z]'))
  }

  // Method to check if the string contains any digits
  bool containsDigit() {
    return contains(RegExp(r'[0-9]'));
    // contains(RegExp(r'\d'))
  }

  // Method to check if the string contains any lowercase letters
  bool containsLowerCase() {
    return contains(RegExp(r'[a-z]'));
    // contains(RegExp(r'[a-z]'))
  }

  // Method to check if the string contains at least 8 characters
  bool contains8chars() {
    return contains(RegExp(r'.{8,}'));
  }

  bool containsSpecialCharacter() {
    // Add other special characters if needed
    return contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    // contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))
  }

  bool containsSpecialCharacterv2() {
    return contains(RegExp(r'(?=.*[^a-zA-Z\d])'));
  }

  bool passwordCheck2() {
    return containsDigit() &&
        containsUppercase() &&
        containsLowerCase() &&
        contains8chars() &&
        containsSpecialCharacterv2();
  }

  bool passwordCheck() {
    return containsDigit() &&
        containsUppercase() &&
        containsLowerCase() &&
        contains8chars() &&
        containsSpecialCharacter();
  }

  /// `true`  ➜ the string contains **at least one** character and every
  ///            character is 0-9.
  /// `false` ➜ empty string, or any non-digit character is present.
  bool get hasDigit => isNotEmpty && RegExp(r'^\d+$').hasMatch(this);
}

// using md5Hashing to generate a random number
String generateRandomString() {
  // get random number between 0.0 and 512.0
  final randomNumber = Random().nextDouble() * 512.0;
  final randomBytes = utf8.encode(randomNumber.toString());
  final randomString = md5.convert(randomBytes).toString();
  return randomString;
}

extension Blank on String? {
  bool get isBlank {
    this?.trim();
    if (this != null && this!.isNotEmpty) return false;

    return true;
  }

  bool get isNotBlank {
    return !isBlank;
  }

  String? get str {
    this?.trim();
    if (this != null && this!.isNotEmpty) return this;

    return null;
  }

  /// Formats a datetime string from "YYYY-MM-DD HH:mm:ss.SSS"
  /// to "Mon DD, YYYY HH:mm".
  /// Example:
  /// "2025-07-03 07:27:42.0".toFormattedDateTime();
  /// Returns "Jul 3, 2025 07:27"
  String toPosTime() {
    if (this == null) {
      return '';
    }
    try {
      final dateTime = DateTime.parse(this!);
      final formatter = DateFormat('MMM d, yyyy HH:mm');
      return formatter.format(dateTime);
    } catch (e) {
      print('Error parsing date string: $this - $e');
      return 'N/A';
    }
  }

  num parseToNumSafely() {
    // Return 0 if the string is null
    if (this == null) return 0;

    final cleaned = this!.replaceAll(',', '');
    if (cleaned.isEmpty) return 0;
    try {
      return num.parse(cleaned);
    } catch (e) {
      return 0;
    }
  }

  /// Safely parses a string with commas to a double, returning 0.0 if null, empty or invalid
  double parseToDoubleSafely() {
    return parseToNumSafely().toDouble();
  }

  /// Safely parses a string with commas to an int, returning 0 if null, empty or invalid
  int parseToIntSafely() {
    return parseToNumSafely().toInt();
  }

  /// Returns the string with commas removed, or "0" if null or empty
  String removeCommas() {
    if (this == null) return "0";

    final cleaned = this!.replaceAll(',', '');
    return cleaned.isEmpty ? "0" : cleaned;
  }

  /// Converts "2025-07-21 10:14:28.0" ➜ "10:14".
  /// If the source is `null` or malformed, returns "n/a".
  String toHm() {
    if (this == null) return 'n/a';
    try {
      final dt = DateTime.parse(this!); // parses "YYYY-MM-DD HH:MM:SS[.f]"
      String two(int n) => n.toString().padLeft(2, '0');
      return '${two(dt.hour)}:${two(dt.minute)}';
    } catch (_) {
      return 'n/a';
    }
  }

  String formatCurrencyNoSymbol() {
    if (this == null) return 'n/a';
    final formatedString = this!.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return formatedString;
  }
}

extension DateFormatExtension on String {
  String formatDateString({
    String inputFormat = "yyyy-MM-dd HH:mm:ss.S",
    String outputFormat = "yyyy/MM/dd",
  }) {
    try {
      final inputDate = DateTime.parse(this);
      final outputFormatter = DateFormat(outputFormat);
      return outputFormatter.format(inputDate);
    } catch (e) {
      // Handle parsing errors
      return this; // Return the original string on error
    }
  }

  DateTime toDateTime() {
    final parts = split('-');
    if (parts.length == 3) {
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      return DateTime(year, month, day);
    } else {
      throw const FormatException("Invalid date format, expected 'yyyy-MM-dd'");
    }
  }
}
