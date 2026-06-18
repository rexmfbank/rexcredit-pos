import 'package:equatable/equatable.dart';

class PosQuickPurchaseResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic data;

  const PosQuickPurchaseResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory PosQuickPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PosQuickPurchaseResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "PosQuickPurchaseResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
