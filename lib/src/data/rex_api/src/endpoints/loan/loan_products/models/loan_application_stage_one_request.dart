class LoanApplicationStageOneRequest {
  final String productCode;
  final String loanTitle;
  final String? section;
  final String? loanRefNo;
  final double amountApplied;
  final int tenor;
  final String purpose;
  final String? status;
  final String? maritalStatus;
  final String? residentialAddress;
  final String? inResidenceSince;
  final int? noOfDependants;
  final String? educationalStatus;
  final String? employmentStatus;

  LoanApplicationStageOneRequest({
    required this.productCode,
    required this.loanTitle,
    required this.section,
    required this.loanRefNo,
    required this.amountApplied,
    required this.tenor,
    required this.purpose,
    this.status,
    this.maritalStatus,
    this.residentialAddress,
    this.inResidenceSince,
    this.noOfDependants,
    this.educationalStatus,
    this.employmentStatus,
  });

  Map<String, dynamic> toJson() => {
        "productCode": productCode,
        "loanTitle": loanTitle,
        "section": section,
        "loanRefNo": loanRefNo,
        "amountApplied": amountApplied,
        "tenor": tenor,
        "purpose": purpose,
        "status": status,
        "maritalStatus": maritalStatus,
        "residentialAddress": residentialAddress,
        "inResidenceSince": inResidenceSince,
        "noOfDependants": noOfDependants,
        "educationalStatus": educationalStatus,
        "employmentStatus": employmentStatus,
      };

  @override
  String toString() => "LoanApplicationStageOneRequest: ${toJson()}";
}
