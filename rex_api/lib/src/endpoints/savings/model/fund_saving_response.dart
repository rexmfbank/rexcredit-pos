import 'package:equatable/equatable.dart';

class FundSavingResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final Object? data;

  const FundSavingResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const FundSavingResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory FundSavingResponse.fromJson(Map<String, dynamic> json) {
    return FundSavingResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "FundSavingResponse",
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
