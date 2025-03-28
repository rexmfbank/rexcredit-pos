import 'package:equatable/equatable.dart';

class FixedDepositWalletBalance extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final num? data;

  const FixedDepositWalletBalance({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const FixedDepositWalletBalance.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory FixedDepositWalletBalance.fromJson(Map<String, dynamic> json) {
    return FixedDepositWalletBalance(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "FixedDepositWalletBalance",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}

class FixedDepositBalance extends Equatable {
  final num total;

  const FixedDepositBalance({
    required this.total,
  });

  const FixedDepositBalance.empty() : total = 0.0;

  factory FixedDepositBalance.fromJson(Map<String, dynamic> json) {
    return FixedDepositBalance(
      total: json['total'] as num,
    );
  }

  @override
  String toString() => {
        "CLASS": "FixedDepositBalance",
        "total": total,
      }.toString();

  @override
  List<Object?> get props => [total];
}
