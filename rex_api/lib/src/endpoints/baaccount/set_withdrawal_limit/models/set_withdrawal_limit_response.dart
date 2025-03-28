import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class SetWithdrawalLimitResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final UpdateBusinessResponseData? data;

  const SetWithdrawalLimitResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data
  });

  SetWithdrawalLimitResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = UpdateBusinessResponseData.empty();

  factory SetWithdrawalLimitResponse.fromJson(Map<String, dynamic> json) {
    return SetWithdrawalLimitResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'] != null ? UpdateBusinessResponseData.fromJson(json['data']) : UpdateBusinessResponseData.empty(),
    );
  }

  @override
  String toString() => {
        "CLASS": "SetWithdrawalLimitResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
