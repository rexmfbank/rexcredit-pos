import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class GetLoanDetailResponseData extends Equatable {
  final String? accountNo;
  final String? externalId;
  // final LoanStatus? status;
  final String? loanProductId;
  final double? principal;
  final double? approvedPrincipal;
  final double? loanInterest;
  final double? totalExpectedRepayment;
  final num? amountRepaid;
  final double? totalOutstanding;
  final double? totalOverdue;
  final String? numberOfRepayments;
  final String? repaymentFrequencyType;
  final double? interestRatePerPeriod;
  final String? interestRateFrequencyType;
  final String? expectedFirstRepaymentOnDate;
  final double? percentage;
  final String? percentageText;
  final String? startDate;
  final String? endDate;
  final List<RepaymentSchedule>? repaymentSchedule;

  const GetLoanDetailResponseData(
      {required this.accountNo,
      required this.externalId,
      // required this.status,
      required this.loanProductId,
      required this.principal,
      required this.approvedPrincipal,
      required this.loanInterest,
      required this.totalExpectedRepayment,
      required this.amountRepaid,
      required this.totalOutstanding,
      required this.totalOverdue,
      required this.numberOfRepayments,
      required this.repaymentFrequencyType,
      required this.interestRatePerPeriod,
      required this.interestRateFrequencyType,
      required this.expectedFirstRepaymentOnDate,
      required this.percentage,
      required this.percentageText,
      required this.startDate,
      required this.endDate,
      required this.repaymentSchedule});

  GetLoanDetailResponseData.empty()
      : accountNo = '',
        externalId = '',
        // status = null,
        loanProductId = '',
        principal = 0.0,
        approvedPrincipal = 0.0,
        loanInterest = 0.0,
        totalExpectedRepayment = 0.0,
        amountRepaid = 0.0,
        totalOutstanding = 0.0,
        totalOverdue = 0.0,
        numberOfRepayments = '',
        repaymentFrequencyType = '',
        interestRatePerPeriod = 0.0,
        interestRateFrequencyType = '',
        expectedFirstRepaymentOnDate = '',
        percentage = 0.0,
        percentageText = '',
        startDate = '',
        endDate = '',
        repaymentSchedule = [];

  factory GetLoanDetailResponseData.fromJson(Map<String, dynamic> json) =>
      GetLoanDetailResponseData(
        accountNo: json["accountNo"],
        externalId: json["externalId"],
        // status:
        //     json["status"] != null ? LoanStatus.fromJson(json["status"]) : null,
        loanProductId: json["loanProductId"],
        principal: json["principal"],
        approvedPrincipal: json["approvedPrincipal"],
        loanInterest: json["loanInterest"],
        totalExpectedRepayment: json["totalExpectedRepayment"],
        amountRepaid: json["amountRepaid"],
        totalOutstanding: json["totalOutstanding"],
        totalOverdue: json["totalOverdue"],
        numberOfRepayments: json["numberOfRepayments"],
        repaymentFrequencyType: json["repaymentFrequencyType"],
        interestRatePerPeriod: json["interestRatePerPeriod"],
        interestRateFrequencyType: json["interestRateFrequencyType"],
        expectedFirstRepaymentOnDate: json["expectedFirstRepaymentOnDate"],
        percentage: json["percentage"],
        percentageText: json["percentageText"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        repaymentSchedule: json["repaymentSchedule"] == null
            ? []
            : (json["repaymentSchedule"] as List)
                .map((e) => RepaymentSchedule.fromJson(e))
                .toList(),
      );

  @override
  List<Object?> get props => [
        accountNo,
        externalId,
        // status,
        loanProductId,
        principal,
        approvedPrincipal,
        loanInterest,
        totalExpectedRepayment,
        amountRepaid,
        totalOutstanding,
        totalOverdue,
        numberOfRepayments,
        repaymentFrequencyType,
        interestRateFrequencyType,
        interestRatePerPeriod,
        expectedFirstRepaymentOnDate,
        percentage,
        percentageText,
        startDate,
        endDate,
        repaymentSchedule
      ];
}
