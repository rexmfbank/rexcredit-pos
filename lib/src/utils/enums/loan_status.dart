enum LoanStatus {
  completed('COMPLETED', 'Completed'),
  declined('DECLINED', 'Declined'),
  rejected('REJECTED', 'Rejected'),
  terminated('TERMINATED', 'Terminated'),
  accepted('ACCEPTED', 'Accepted'),
  applied('APPLIED', 'Applied'),
  initiated('INITIATED', 'Initiated'),
  closed('CLOSED', 'Closed'),
  none('NONE', 'None');

  const LoanStatus(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension LoanStatusFromString on String? {
  LoanStatus? get jsonLoanStatus {
    return LoanStatus.values.firstWhere(
      (element) => element.jsonString == this,
      orElse: () => LoanStatus.none,
    );
  }

  LoanStatus? get displayLoanStatus {
    return LoanStatus.values.firstWhere(
      (element) => element.displayString == this,
      orElse: () => LoanStatus.none,
    );
  }
}
