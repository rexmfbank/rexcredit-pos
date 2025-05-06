import 'package:equatable/equatable.dart';

class CompleteOnboardResponse extends Equatable {
  final String? accountNumber;
  final String? username;
  final String responseCode;
  final String responseMessage;
  final Object? data;

  const CompleteOnboardResponse({
    this.accountNumber,
    this.username,
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const CompleteOnboardResponse.empty()
      : accountNumber = null,
        username = null,
        responseCode = '',
        responseMessage = '',
        data = null;

  factory CompleteOnboardResponse.fromJson(Map<String, dynamic> json) {
    return CompleteOnboardResponse(
      accountNumber: json['accountNo'] as String?,
      username: json['username'] as String?,
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "CompleteOnboardResponse",
        "accountNo": accountNumber,
        "username": username,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [
        accountNumber,
        username,
        responseCode,
        responseMessage,
        data,
      ];
}
