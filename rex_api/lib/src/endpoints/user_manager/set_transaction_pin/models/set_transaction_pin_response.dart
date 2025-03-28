import 'package:equatable/equatable.dart';

class SetTransactionPinResponse extends Equatable {
  final String responseCode;
  final String responseMessage;

  const SetTransactionPinResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  const SetTransactionPinResponse.empty()
      : responseCode = '',
        responseMessage = '';

  factory SetTransactionPinResponse.fromJson(Map<String, dynamic> json) {
    return SetTransactionPinResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "SetTransactionPinResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage];
}
