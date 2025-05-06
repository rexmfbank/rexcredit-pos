import 'package:equatable/equatable.dart';

class FetchTargetSavingsData extends Equatable {
  final int id;
  final String productCode;
  final String entityCode;
  final String username;
  final String planName;
  final String targetAmount;
  final String? source;
  final DateTime? maturityDate;
  final String frequency;
  final String initialAmount;
  final String? recurringAmount;
  final String totalAmount;
  final String? accruedInterest;
  final String status;
  final String? amountPaidOut;

  const FetchTargetSavingsData({
    required this.id,
    required this.productCode,
    required this.entityCode,
    required this.username,
    required this.planName,
    required this.targetAmount,
    required this.source,
    required this.maturityDate,
    required this.frequency,
    required this.initialAmount,
    required this.recurringAmount,
    required this.totalAmount,
    required this.accruedInterest,
    required this.status,
    required this.amountPaidOut,
  });

  const FetchTargetSavingsData.empty()
      : id = 0,
        productCode = '',
        entityCode = '',
        username = '',
        planName = '',
        targetAmount = '',
        source = null,
        maturityDate = null,
        frequency = '',
        initialAmount = '',
        recurringAmount = null,
        totalAmount = '',
        accruedInterest = null,
        status = '',
        amountPaidOut = null;

  factory FetchTargetSavingsData.fromJson(Map<String, dynamic> json) {
    return FetchTargetSavingsData(
      id: json['id'] as int,
      productCode: json['productCode'] as String,
      entityCode: json['entityCode'] as String,
      username: json['username'] as String,
      planName: json['planName'] as String,
      targetAmount: json['targetAmount'] as String,
      source: json['source'],
      maturityDate: json['maturityDate'] == null
          ? null
          : DateTime.parse(json['maturityDate']),
      frequency: json['frequency'] as String,
      initialAmount: json['initialAmount'] as String,
      recurringAmount: json['recurringAmount'],
      totalAmount: json['totalAmount'] as String,
      accruedInterest: json['accruedInterest'],
      status: json['status'] as String,
      amountPaidOut: json['amountPaidOut'] as String?,
    );
  }

  @override
  String toString() => {
        "id": id,
        "productCode": productCode,
        "entityCode": entityCode,
        "username": username,
        "planName": planName,
        "targetAmount": targetAmount,
        "source": source,
        "maturityDate": maturityDate,
        "frequency": frequency,
        "initialAmount": initialAmount,
        "recurringAmount": recurringAmount,
        "totalAmount": totalAmount,
        "accruedInterest": accruedInterest,
        "status": status,
        "amountPaidOut": amountPaidOut
      }.toString();

  @override
  List<Object?> get props => [
        id,
        productCode,
        entityCode,
        username,
        planName,
        targetAmount,
        source,
        maturityDate,
        frequency,
        initialAmount,
        recurringAmount,
        totalAmount,
        accruedInterest,
        status,
        amountPaidOut,
      ];
}
