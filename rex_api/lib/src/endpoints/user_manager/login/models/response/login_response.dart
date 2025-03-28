import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/user_manager/login/models/response/login_response_data.dart';

class LoginResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final LoginResponseData data;

  const LoginResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  const LoginResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = const LoginResponseData.empty();

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: LoginResponseData.fromJson(json['data']),
    );
  }

  @override
  String toString() => {
        "CLASS": "LoginResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
