import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class RepaymentData extends Equatable {
  final double? amount;
  final String? interestRate;
  final double? interestAmount;
  final String? tenorFrequency;
  final double? repaymentAmount;
  final int? repaymentCount;
  final String? startDate;
  final double? periodicRepaymentAmount;
  final List<PaymentSchedule>? paymentSchedules;

  RepaymentData({
    this.amount,
    this.interestRate,
    this.interestAmount,
    this.tenorFrequency,
    this.repaymentAmount,
    this.repaymentCount,
    this.startDate,
    this.periodicRepaymentAmount,
    this.paymentSchedules,
  });

  RepaymentData.empty()
      : amount = 0.0,
        interestRate = '',
        interestAmount = 0.0,
        tenorFrequency = '',
        repaymentAmount = 0.0,
        repaymentCount = 1,
        startDate = '',
        periodicRepaymentAmount = 0.0,
        paymentSchedules = [];

  factory RepaymentData.fromJson(Map<String, dynamic> json) => RepaymentData(
        amount: json["amount"],
        interestRate: json["interestRate"],
        interestAmount: json["interestAmount"],
        tenorFrequency: json["tenorFrequency"],
        repaymentAmount: json["repaymentAmount"],
        repaymentCount: json['repaymentCount'],
        startDate: json['startDate'],
        periodicRepaymentAmount: json['periodicRepaymentAmount'],
        paymentSchedules: json["paymentSchedules"] == null
            ? []
            : (json["paymentSchedules"] as List)
                .map((e) => PaymentSchedule.fromJson(e))
                .toList(),
      );

  @override
  List<Object?> get props => [
        amount,
        interestRate,
        interestAmount,
        tenorFrequency,
        repaymentAmount,
        repaymentCount,
        startDate,
        periodicRepaymentAmount,
        paymentSchedules,
      ];
}
