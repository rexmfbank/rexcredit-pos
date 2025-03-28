import 'package:equatable/equatable.dart';

class LoanData extends Equatable {
  final String responseCode;
  final String responseMessage;
  // final LoanDetail? data;

  LoanData({
    required this.responseCode,
    required this.responseMessage,
    // this.data,
  });

  @override
  List<Object?> get props => [
    responseCode, 
    responseMessage, 
    // data
    ];

  factory LoanData.fromJson(Map<String, dynamic> json) {
    return LoanData(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      // data: json['data'] != null ? LoanDetail.fromJson(json['data']) : null,
    );
  }
}

class LoanDetail extends Equatable {
  final String? responseCode;
  final String? responseMessage;
  final String? accountNo;
  final String? externalId;
  final LoanStatus? status;
  final int? loanProductId;
  final double? principal;
  final double? approvedPrincipal;
  final int? numberOfRepayments;
  final String? repaymentFrequencyType;
  final double? interestRatePerPeriod;
  final String? interestRateFrequencyType;
  final String? expectedFirstRepaymentOnDate;
  final double? percentage;
  final String? percentageText;
  final String? startDate;
  final String? endDate;
  final List<RepaymentSchedule>? repaymentSchedule;

  LoanDetail({
    this.responseCode,
    this.responseMessage,
    this.accountNo,
    this.externalId,
    this.status,
    this.loanProductId,
    this.principal,
    this.approvedPrincipal,
    this.numberOfRepayments,
    this.repaymentFrequencyType,
    this.interestRatePerPeriod,
    this.interestRateFrequencyType,
    this.expectedFirstRepaymentOnDate,
    this.percentage,
    this.percentageText,
    this.startDate,
    this.endDate,
    this.repaymentSchedule,
  });

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        accountNo,
        externalId,
        status,
        loanProductId,
        principal,
        approvedPrincipal,
        numberOfRepayments,
        repaymentFrequencyType,
        interestRatePerPeriod,
        interestRateFrequencyType,
        expectedFirstRepaymentOnDate,
        percentage,
        percentageText,
        startDate,
        endDate,
        repaymentSchedule,
      ];

  factory LoanDetail.fromJson(Map<String, dynamic> json) {
    return LoanDetail(
      responseCode: json['responseCode'] as String?,
      responseMessage: json['responseMessage'] as String?,
      accountNo: json['accountNo'] as String?,
      externalId: json['externalId'] as String?,
      status:
          json['status'] != null ? LoanStatus.fromJson(json['status']) : null,
      loanProductId: json['loanProductId'] as int?,
      principal: json['principal'] as double?,
      approvedPrincipal: json['approvedPrincipal'] as double?,
      numberOfRepayments: json['numberOfRepayments'] as int?,
      repaymentFrequencyType: json['repaymentFrequencyType'] as String?,
      interestRatePerPeriod: json['interestRatePerPeriod'] as double?,
      interestRateFrequencyType: json['interestRateFrequencyType'] as String?,
      expectedFirstRepaymentOnDate:
          json['expectedFirstRepaymentOnDate'] as String?,
      percentage: json['percentage'] as double?,
      percentageText: json['percentageText'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      repaymentSchedule: (json['repaymentSchedule'] as List<dynamic>?)
          ?.map((e) => RepaymentSchedule.fromJson(e))
          .toList(),
    );
  }
}

class LoanStatus extends Equatable {
  final int? id;
  final String? code;
  final String? value;
  final bool? pendingApproval;
  final bool? waitingForDisbursal;
  final bool? active;
  final bool? closedObligationsMet;
  final bool? closedWrittenOff;
  final bool? closedRescheduled;
  final bool? closed;
  final bool? overpaid;

  LoanStatus({
    this.id,
    this.code,
    this.value,
    this.pendingApproval,
    this.waitingForDisbursal,
    this.active,
    this.closedObligationsMet,
    this.closedWrittenOff,
    this.closedRescheduled,
    this.closed,
    this.overpaid,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        value,
        pendingApproval,
        waitingForDisbursal,
        active,
        closedObligationsMet,
        closedWrittenOff,
        closedRescheduled,
        closed,
        overpaid,
      ];

  factory LoanStatus.fromJson(Map<String, dynamic> json) {
    return LoanStatus(
      id: json['id'] as int?,
      code: json['code'] as String?,
      value: json['value'] as String?,
      pendingApproval: json['pendingApproval'] as bool?,
      waitingForDisbursal: json['waitingForDisbursal'] as bool?,
      active: json['active'] as bool?,
      closedObligationsMet: json['closedObligationsMet'] as bool?,
      closedWrittenOff: json['closedWrittenOff'] as bool?,
      closedRescheduled: json['closedRescheduled'] as bool?,
      closed: json['closed'] as bool?,
      overpaid: json['overpaid'] as bool?,
    );
  }
}

class RepaymentSchedule extends Equatable {
  final String? dueDate;
  final String? status;
  final int? period;
  final double? amountDue;
  final double? amountPaid;
  final double? outstandingAmount;

  RepaymentSchedule({
    this.dueDate,
    this.status,
    this.period,
    this.amountDue,
    this.amountPaid,
    this.outstandingAmount,
  });

  @override
  List<Object?> get props => [
        dueDate,
        status,
        period,
        amountDue,
        amountPaid,
        outstandingAmount,
      ];

  factory RepaymentSchedule.fromJson(Map<String, dynamic> json) {
    return RepaymentSchedule(
      dueDate: json['dueDate'] as String?,
      status: json['status'] as String?,
      period: json['period'] as int?,
      amountDue: json['amountDue'] as double?,
      amountPaid: json['amountPaid'] as double?,
      outstandingAmount: json['outstandingAmount'] as double?,
    );
  }
}
