import 'package:equatable/equatable.dart';

class InitiatePaymentResponseData extends Equatable {
  final String reference;
  final String amount;
  final String callbackUrl;
  final String paymentUrl;

  const InitiatePaymentResponseData({
    required this.reference,
    required this.amount,
    required this.callbackUrl,
    required this.paymentUrl,
  });

  const InitiatePaymentResponseData.empty()
      : reference = '',
        amount = '',
        callbackUrl = '',
        paymentUrl = '';

  factory InitiatePaymentResponseData.fromJson(Map<String, dynamic> json) {
    return InitiatePaymentResponseData(
      reference: json['reference'] as String,
      amount: json['amount'] as String,
      callbackUrl: json['callbackUrl'] as String,
      paymentUrl: json['paymentUrl'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "InitiatePaymentResponseData",
        "reference": reference,
        "amount": amount,
        "callbackUrl": callbackUrl,
        "paymentUrl": paymentUrl,
      }.toString();

  @override
  List<Object?> get props => [reference, amount, callbackUrl, paymentUrl];
}
