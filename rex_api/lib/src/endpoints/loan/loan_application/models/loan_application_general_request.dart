class LoanApplicationGeneralRequest {
  final String? loanRefNo;
  final String? reason;
  final String? status;

  LoanApplicationGeneralRequest({
    this.loanRefNo,
    this.reason,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "loanRefNo": loanRefNo,
        "reason": reason,
        "status": status,
      };
}
