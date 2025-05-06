import 'package:equatable/equatable.dart';

class RegisterResponseData extends Equatable {
  final String? accountNumber;
  final String username;
  final String? responseCode;
  final String? responseMessage;

  const RegisterResponseData({
    required this.accountNumber,
    required this.username,
    this.responseCode,
    this.responseMessage,
  });

  const RegisterResponseData.empty()
      : accountNumber = '',
        username = '',
        responseCode = null,
        responseMessage = null;

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) {
    return RegisterResponseData(
      accountNumber: json['accountNo'],
      username: json['username'] as String,
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
    );
  }

  @override
  String toString() => {
        "CLASS": "RegisterResponseData",
        "accountNumber": accountNumber,
        "username": username,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
      }.toString();

  @override
  List<Object?> get props => [
        accountNumber,
        username,
        responseCode,
        responseMessage,
      ];
}
