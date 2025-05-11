
class ComputeLoanRequest {
  final num loanAmount;
  final String loanProductCode;
  final int tenor;
  final String? startDate;

  ComputeLoanRequest({
    required this.loanAmount,
    required this.loanProductCode,
    required this.tenor,
    this.startDate,
  });

  Map<String, dynamic> toJson() => {
    "loanAmount": loanAmount,
    "loanProductCode": loanProductCode,
    "tenor": tenor,
    "startDate": startDate
  };
  
}
