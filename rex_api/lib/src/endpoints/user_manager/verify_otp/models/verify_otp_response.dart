import 'package:equatable/equatable.dart';

class VerifyOtpResponse extends Equatable {
  final String responseCode;
  final String responseMessage;

  const VerifyOtpResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  const VerifyOtpResponse.empty()
      : responseCode = '',
        responseMessage = '';

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "VerifyOtpResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage];
}
