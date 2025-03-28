class SearchBeneficiaryQuery {
  final String name;
  final String accountNumber;

  SearchBeneficiaryQuery({
    required this.name,
    required this.accountNumber,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "accountNum": accountNumber,
  };
}
