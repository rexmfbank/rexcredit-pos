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
    return split(" ").map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(" ");
  }

  String capitalizeEachWordv2() {
    return replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }
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
