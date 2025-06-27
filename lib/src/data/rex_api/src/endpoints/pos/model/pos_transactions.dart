import 'package:equatable/equatable.dart';

class PosTransactions extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic data;

  const PosTransactions({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory PosTransactions.fromJson(Map<String, dynamic> json) {
    return PosTransactions(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "PosTransactions",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
