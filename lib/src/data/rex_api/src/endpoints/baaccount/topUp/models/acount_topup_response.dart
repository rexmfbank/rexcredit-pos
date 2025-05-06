import 'package:equatable/equatable.dart';

class AccountTopUpResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final Object? data;

  const AccountTopUpResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  const AccountTopUpResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory AccountTopUpResponse.fromJson(Map<String, dynamic> json) {
    return AccountTopUpResponse(
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
