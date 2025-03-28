class DepositInterestTypeData {
  final String? countryCode;
  final double? reduction;
  final bool? active;
  final String? interestType;
  final Object? description;

  const DepositInterestTypeData({
    this.countryCode,
    this.reduction,
    this.active,
    this.interestType,
    this.description,
  });

  const DepositInterestTypeData.empty()
      : countryCode = null,
        reduction = null,
        active = null,
        interestType = null,
        description = null;

  factory DepositInterestTypeData.fromJson(Map<String, dynamic> json) =>
      DepositInterestTypeData(
        countryCode: json["countryCode"],
        reduction: json["reduction"]?.toDouble(),
        active: json["active"],
        interestType: json["interestType"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "reduction": reduction,
        "active": active,
        "interestType": interestType,
        "description": description,
      };

  @override
  String toString() => {
        "CLASS": "DepositInterestTypeData",
        "countryCode": countryCode,
        "reduction": reduction,
        "active": active,
        "interestType": interestType,
        "description": description,
      }.toString();
}
