import 'dart:convert';

import 'package:rex_app/src/modules/shared/models/card_payments/card_payment_information.dart';
import 'package:rex_app/src/utils/enums/card_payment_status.dart';

class CardPaymentResult {
  final CardPaymentStatus status;
  final CardPaymentInformation? data;
  final String? extraMessage;

  const CardPaymentResult({
    required this.status,
    this.data,
    this.extraMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status.jsonString,
      'data': data,
      'extraMessage': extraMessage,
    };
  }

  factory CardPaymentResult.fromMap(Map<String, dynamic> map) {
    return CardPaymentResult(
      status: map['status'],
      data: map['data'] == null ? null : CardPaymentInformation.fromMap(map['data']),
      extraMessage: map['extraMessage'],
    );
  }

  static CardPaymentResult cardPaymentResultFromMap(String str) =>
      CardPaymentResult.fromMap(json.decode(str));

  static String cardPaymentResultToMap(CardPaymentResult? data) =>
      json.encode(data!.toMap());

  @override
  String toString() {
    return 'CardPaymentResult{status: $status, data: $data, extraMessage: $extraMessage}';
  }
}
