import 'package:equatable/equatable.dart';

class ResendOtpResponse extends Equatable {
  final String responseCode;
  final String responseMessage;

  const ResendOtpResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  const ResendOtpResponse.empty()
      : responseCode = '',
        responseMessage = '';

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "ResendOtpResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage];
}
