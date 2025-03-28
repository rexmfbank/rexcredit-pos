import 'package:equatable/equatable.dart';

class CardVerificationResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final Object? data;

  const CardVerificationResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const CardVerificationResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory CardVerificationResponse.fromJson(Map<String, dynamic> json) {
    return CardVerificationResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}
