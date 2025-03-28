import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/savings/model/savings_return_response_data.dart';

class SavingsReturnResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final SavingsReturnResponseData? data;

  const SavingsReturnResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  const SavingsReturnResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = const SavingsReturnResponseData.empty();

  factory SavingsReturnResponse.fromJson(Map<String, dynamic> json) {
    return SavingsReturnResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: json['data'] == null ? null : SavingsReturnResponseData.fromJson(json['data']),
    );
  }

  @override
  String toString() => {
        "CLASS": "SavingsReturnResponse",
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
