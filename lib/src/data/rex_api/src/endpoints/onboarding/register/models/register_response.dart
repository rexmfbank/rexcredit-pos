import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class RegisterResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final RegisterResponseData? data;

  const RegisterResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  const RegisterResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'] == null
          ? null
          : RegisterResponseData.fromJson(json['data']),
    );
  }

  @override
  String toString() => {
        "CLASS": "RegisterResponse",
        "code": responseCode,
        "desc": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
