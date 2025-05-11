import 'package:equatable/equatable.dart';

class ComputeLoanResponseData extends Equatable {
  final num? amount;
  final String? interestRate;
  final double? interestAmount;
  final String? tenorFrequency;
  final double? repaymentAmount;
  final int? repaymentCount;
  final String? startDate;
  final double? periodicRepaymentAmount;
  final List<PaymentSchedule>? paymentSchedules;

  const ComputeLoanResponseData(
      {required this.amount,
      required this.interestRate,
      required this.interestAmount,
      required this.tenorFrequency,
      required this.repaymentAmount,
      required this.repaymentCount,
      required this.startDate,
      required this.periodicRepaymentAmount,
      required this.paymentSchedules});

  ComputeLoanResponseData.empty()
      : amount = 0.0,
        interestAmount = 0.0,
        interestRate = '',
        tenorFrequency = '',
        repaymentAmount = 0.0,
        repaymentCount = 1,
        startDate = '',
        periodicRepaymentAmount = 0.0,
        paymentSchedules = [];

  factory ComputeLoanResponseData.fromJson(Map<String, dynamic> json) =>
      ComputeLoanResponseData(
        amount: json["amount"],
        interestRate: json["interestRate"],
        interestAmount: json["interestAmount"],
        tenorFrequency: json["tenorFrequency"],
        repaymentAmount: json["repaymentAmount"],
        repaymentCount: json["repaymentCount"],
        startDate: json["startDate"],
        periodicRepaymentAmount: json["periodicRepaymentAmount"],
        paymentSchedules: json["paymentSchedules"] == null
            ? []
            : (json["paymentSchedules"] as List)
                .map((e) => PaymentSchedule.fromJson(e))
                .toList(),
      );

  @override
  List<Object?> get props => [
    amount,
        interestAmount,
        interestRate,
        tenorFrequency,
        repaymentAmount,
        repaymentCount,
        startDate,
        periodicRepaymentAmount,
        paymentSchedules
  ];
}

class PaymentSchedule {
  final String? date;
  final double? periodicInterestAmount;

  const PaymentSchedule(
      {required this.date, required this.periodicInterestAmount});

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) =>
      PaymentSchedule(
        date: json["date"],
        periodicInterestAmount: json["periodicInterestAmount"],
      );
}
