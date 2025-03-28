class LoanManagementResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final LoanDetail? data;

  LoanManagementResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory LoanManagementResponse.fromJson(Map<String, dynamic> json) =>
      LoanManagementResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null ? null : LoanDetail.fromJson(json["data"]),
      );
}

class LoanDetail {
  final String? responseCode;
  final String? responseMessage;
  final String? appStatus;
  final String? accountNo;
  final String? externalId;
  final Status? status;
  final int? loanProductId;
  final double? principal;
  final double? approvedPrincipal;
  final double? loanInterest;
  final double? totalExpectedRepayment;
  final double? amountRepaid;
  final double? totalOutstanding;
  final num? totalOverdue;
  final int? numberOfRepayments;
  final String? repaymentFrequencyType;
  final double? interestRatePerPeriod;
  final String? interestRateFrequencyType;
  final DateTime? expectedFirstRepaymentOnDate;
  final double? percentage;
  final String? percentageText;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<RepaymentSchedule>? repaymentSchedule;

  LoanDetail({
    this.responseCode,
    this.responseMessage,
    this.appStatus,
    this.accountNo,
    this.externalId,
    this.status,
    this.loanProductId,
    this.principal,
    this.approvedPrincipal,
    this.loanInterest,
    this.totalExpectedRepayment,
    this.amountRepaid,
    this.totalOutstanding,
    this.totalOverdue,
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

  const LoanDetail.empty()
      : responseCode = null,
        responseMessage = null,
        appStatus = null,
        accountNo = null,
        externalId = null,
        status = const Status.empty(),
        loanProductId = null,
        principal = null,
        approvedPrincipal = null,
        loanInterest = null,
        totalExpectedRepayment = null,
        amountRepaid = null,
        totalOutstanding = null,
        totalOverdue = null,
        numberOfRepayments = null,
        repaymentFrequencyType = null,
        interestRatePerPeriod = null,
        interestRateFrequencyType = null,
        expectedFirstRepaymentOnDate = null,
        percentage = null,
        percentageText = null,
        startDate = null,
        endDate = null,
        repaymentSchedule = null;

  factory LoanDetail.fromJson(Map<String, dynamic> json) => LoanDetail(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        appStatus: json["appStatus"],
        accountNo: json["accountNo"],
        externalId: json["externalId"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
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
        expectedFirstRepaymentOnDate:
            json["expectedFirstRepaymentOnDate"] == null
                ? null
                : DateTime.parse(json["expectedFirstRepaymentOnDate"]),
        percentage: json["percentage"],
        percentageText: json["percentageText"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        repaymentSchedule: json["repaymentSchedule"] == null
            ? []
            : List<RepaymentSchedule>.from(json["repaymentSchedule"]!
                .map((x) => RepaymentSchedule.fromJson(x))),
      );
}

class RepaymentSchedule {
  final DateTime? dueDate;
  final String? status;
  final int? period;
  final double? amountDue;
  final num? amountPaid;
  final double? outstandingAmount;

  RepaymentSchedule({
    this.dueDate,
    this.status,
    this.period,
    this.amountDue,
    this.amountPaid,
    this.outstandingAmount,
  });

  factory RepaymentSchedule.fromJson(Map<String, dynamic> json) =>
      RepaymentSchedule(
        dueDate:
            json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        status: json["status"],
        period: json["period"],
        amountDue: json["amountDue"]?.toDouble(),
        amountPaid: json["amountPaid"],
        outstandingAmount: json["outstandingAmount"]?.toDouble(),
      );
}

class Status {
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

  Status({
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

  const Status.empty()
      : id = null,
        code = null,
        value = null,
        pendingApproval = null,
        waitingForDisbursal = null,
        active = null,
        closedObligationsMet = null,
        closedWrittenOff = null,
        closedRescheduled = null,
        closed = null,
        overpaid = null;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        code: json["code"],
        value: json["value"],
        pendingApproval: json["pendingApproval"],
        waitingForDisbursal: json["waitingForDisbursal"],
        active: json["active"],
        closedObligationsMet: json["closedObligationsMet"],
        closedWrittenOff: json["closedWrittenOff"],
        closedRescheduled: json["closedRescheduled"],
        closed: json["closed"],
        overpaid: json["overpaid"],
      );
}
