import 'package:equatable/equatable.dart';

class PosQuickPurchaseRequest extends Equatable {
  final num amount;
  final String maskedPan;
  final String merchantName;
  final String stan;
  final String statusCode;
  final String terminalId;
  final String bankName;
  final String transactionType;
  final String rrn;

  /// "datetime": "2025-06-27 09:41"
  final String datetime;

  const PosQuickPurchaseRequest({
    required this.amount,
    required this.maskedPan,
    required this.merchantName,
    required this.stan,
    required this.statusCode,
    required this.terminalId,
    required this.bankName,
    required this.transactionType,
    required this.rrn,
    required this.datetime,
  });

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "maskedPan": maskedPan,
        "merchantName": merchantName,
        "stan": stan,
        "statusCode": statusCode,
        "terminalID": terminalId,
        "bankName": bankName,
        "transactionType": transactionType,
        "rrn": rrn,
        "datetime": datetime
      };

  @override
  String toString() => "PosQuickPurchaseRequest: ${toJson()}";

  @override
  List<Object?> get props => [];
}
