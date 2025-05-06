import 'package:equatable/equatable.dart';

class VerifyNewDeviceResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? data;

  const VerifyNewDeviceResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const VerifyNewDeviceResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory VerifyNewDeviceResponse.fromJson(Map<String, dynamic> json) {
    return VerifyNewDeviceResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'],
    );
  }

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
