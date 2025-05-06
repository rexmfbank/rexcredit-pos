class DepositInterestRateRequest {
  final String? amount;
  final String? duration;
  final String? interestType;

  DepositInterestRateRequest({
    this.amount,
    this.duration,
    this.interestType,
  });

  factory DepositInterestRateRequest.fromJson(Map<String, dynamic> json) =>
      DepositInterestRateRequest(
        amount: json["amount"],
        duration: json["duration"],
        interestType: json["interestType"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "duration": duration,
        "interestType": interestType,
      };

  @override
  String toString() => {
        "CLASS": "DepositInterestRateRequest",
        "amount": amount,
        "duration": duration,
        "interestType": interestType,
      }.toString();
}
