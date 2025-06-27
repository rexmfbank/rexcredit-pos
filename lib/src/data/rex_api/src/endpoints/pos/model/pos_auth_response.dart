import 'package:equatable/equatable.dart';

class PosAuthResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic data;

  const PosAuthResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory PosAuthResponse.fromJson(Map<String, dynamic> json) {
    return PosAuthResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "PosAuthResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
