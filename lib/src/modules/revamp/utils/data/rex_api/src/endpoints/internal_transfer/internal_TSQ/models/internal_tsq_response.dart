import 'package:equatable/equatable.dart';

class InternalTSQResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? data;

  InternalTSQResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data
  });

  InternalTSQResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory InternalTSQResponse.fromJson(Map<String, dynamic> json) {
    return InternalTSQResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json["data"]
    );
  }

  @override
  List<Object?> get props => [
    responseCode,
    responseMessage,
    data
  ];
}
