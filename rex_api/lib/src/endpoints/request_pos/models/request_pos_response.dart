import 'package:equatable/equatable.dart';

class RequestPOSResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic data;

  const RequestPOSResponse(
      {required this.responseCode,
      required this.responseMessage,
      required this.data});

  factory RequestPOSResponse.fromJson(Map<String, dynamic> json) {
    return RequestPOSResponse(
        responseCode: json['responseCode'],
        responseMessage: json['responseMessage'],
        data: json['data']);
  }

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
