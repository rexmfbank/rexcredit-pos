import 'package:equatable/equatable.dart';
import 'initiate_payment_response_data.dart';

class CardInitiatePaymentResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final InitiatePaymentResponseData data;

  const CardInitiatePaymentResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  const CardInitiatePaymentResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = const InitiatePaymentResponseData.empty();

  factory CardInitiatePaymentResponse.fromJson(Map<String, dynamic> json) {
    return CardInitiatePaymentResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: InitiatePaymentResponseData.fromJson(json['data']),
    );
  }

  @override
  String toString() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}
