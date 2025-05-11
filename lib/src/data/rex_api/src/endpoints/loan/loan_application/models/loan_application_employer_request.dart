
class LoanApplicationEmployerRequest {
  final String? section;
  final String? loanRefNo;
  final String employmentStatus;
  final String employerName;
  final String monthlyIncome;
  final String? employerState;
  final String? employerStateLga;
  final String? industry;
  final String? sector;
  final String? employmentStartDate;
  final String? workEmail;

  LoanApplicationEmployerRequest({
    required this.section,
    required this.loanRefNo,
    required this.employmentStatus,
    required this.employerName,
    required this.monthlyIncome,
    required this.employerState,
    required this.employerStateLga,
    this.industry,
    this.sector,
    this.employmentStartDate,
    this.workEmail,
  });

  Map<String, dynamic> toJson() => {
    "section": section,
    "loanRefNo": loanRefNo,
    "employmentStatus": employmentStatus,
    "employerName": employerName,
    "monthlyIncome": monthlyIncome,
    "employerState": employerState,
    "employerStateLga": employerStateLga,
    "industry": industry,
    "sector": sector,
    "employmentStartDate": employmentStartDate,
    "workEmail": workEmail,
  };

}