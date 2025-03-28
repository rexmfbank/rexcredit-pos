import 'dart:convert';

class CardPaymentRequest {
  final String amount;
  final String print;
  final String transType;
  final String stan;
  final String rrn;

  const CardPaymentRequest({
    required this.amount,
    required this.print,
    required this.transType,
    required this.stan,
    required this.rrn,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'print': print,
      'transType': transType,
      'stan': stan,
      'rrn': rrn,
    };
  }

  factory CardPaymentRequest.fromMap(Map<String, dynamic> map) {
    return CardPaymentRequest(
      amount: map['amount'],
      print: map['print'],
      transType: map['transType'],
      stan: map['stan'],
      rrn: map['rrn'],
    );
  }

  static CardPaymentRequest cardPaymentResponseFromMap(String str) =>
      CardPaymentRequest.fromMap(json.decode(str));

  static String cardPaymentResponseToMap(CardPaymentRequest? data) =>
      json.encode(data!.toMap());

  @override
  String toString() {
    return 'CardPaymentRequest{amount: $amount, print: $print, transType: $transType}';
  }
}

