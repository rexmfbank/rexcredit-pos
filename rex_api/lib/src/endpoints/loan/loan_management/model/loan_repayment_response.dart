import 'package:equatable/equatable.dart';

class LoanRepaymentResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final Object? data;

  const LoanRepaymentResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  const LoanRepaymentResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory LoanRepaymentResponse.fromJson(Map<String, dynamic> json) {
    return LoanRepaymentResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "LoanRepaymentResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}
