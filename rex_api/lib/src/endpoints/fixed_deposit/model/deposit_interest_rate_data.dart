class DepositInterestRateData {
  final num? rate;
  final num? amount;
  final num? interest;
  final num? totalAmount;
  final int? duration;
  final DateTime? maturityDate;
  final String? interestType;

  DepositInterestRateData({
    this.rate,
    this.amount,
    this.interest,
    this.totalAmount,
    this.duration,
    this.maturityDate,
    this.interestType,
  });

  const DepositInterestRateData.empty()
      : rate = null,
        amount = null,
        interest = null,
        totalAmount = null,
        duration = null,
        maturityDate = null,
        interestType = null;

  factory DepositInterestRateData.fromJson(Map<String, dynamic> json) =>
      DepositInterestRateData(
        rate: json["rate"],
        amount: json["amount"],
        interest: json["interest"],
        totalAmount: json["totalAmount"],
        duration: json["duration"],
        maturityDate: json["maturityDate"] == null
            ? null
            : DateTime.parse(json["maturityDate"]),
        interestType: json["interestType"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "amount": amount,
        "interest": interest,
        "totalAmount": totalAmount,
        "duration": duration,
        "maturityDate": maturityDate?.toIso8601String(),
        "interestType": interestType,
      };

  @override
  String toString() => {
        "CLASS": "DepositInterestRateData",
        "rate": rate,
        "amount": amount,
        "interest": interest,
        "totalAmount": totalAmount,
        "duration": duration,
        "maturityDate": maturityDate?.toIso8601String(),
        "interestType": interestType,
      }.toString();
}
