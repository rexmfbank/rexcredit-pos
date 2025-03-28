import 'package:equatable/equatable.dart';

class UpdateUserResponse extends Equatable {
  final String responseCode;
  final String responseMessage;

  const UpdateUserResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  const UpdateUserResponse.empty()
      : responseCode = '',
        responseMessage = '';

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "UpdateUserResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage];
}
