import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class UpdateBusinessResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final UpdateBusinessInfoResponseData? data;

  const UpdateBusinessResponse(
      {required this.responseCode, required this.responseMessage, this.data});

  UpdateBusinessResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = UpdateBusinessInfoResponseData.empty();

  factory UpdateBusinessResponse.fromJson(Map<String, dynamic> json) {
    return UpdateBusinessResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'] != null
          ? UpdateBusinessInfoResponseData.fromJson(json['data'])
          : UpdateBusinessInfoResponseData.empty(),
    );
  }

  @override
  String toString() => {
        "CLASS": "UpdateBusinessResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
