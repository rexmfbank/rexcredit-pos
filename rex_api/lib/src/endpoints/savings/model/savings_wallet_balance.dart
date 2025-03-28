import 'package:equatable/equatable.dart';

class SavingsWalletBalance extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final SavingsBalance? data;

  const SavingsWalletBalance({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const SavingsWalletBalance.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory SavingsWalletBalance.fromJson(Map<String, dynamic> json) {
    return SavingsWalletBalance(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'] == null ? null : SavingsBalance.fromJson(json['data']),
    );
  }

  @override
  String toString() => {
        "CLASS": "SavingsWalletBalance",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];
}

class SavingsBalance extends Equatable {
  final num total;

  const SavingsBalance({
    required this.total,
  });

  const SavingsBalance.empty() : total = 0.0;

  factory SavingsBalance.fromJson(Map<String, dynamic> json) {
    return SavingsBalance(
      total: json['total'] as num,
    );
  }

  @override
  String toString() => {
        "CLASS": "SavingsBalance",
        "total": total,
      }.toString();

  @override
  List<Object?> get props => [total];
}
