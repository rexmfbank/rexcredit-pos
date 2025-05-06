class DepositData {
  final int? id;
  final String? productCode;
  final String? entityCode;
  final String? username;
  final String? planName;
  final String? amount;
  final String? sourceAccount;
  final DateTime? maturityDate;
  final String? totalAmount;
  final String? interestAccrued;
  final String? status;
  final Object? amountPaid;
  final int? duration;

  const DepositData({
    this.id,
    this.productCode,
    this.entityCode,
    this.username,
    this.planName,
    this.amount,
    this.sourceAccount,
    this.maturityDate,
    this.totalAmount,
    this.interestAccrued,
    this.status,
    this.amountPaid,
    this.duration,
  });

  const DepositData.empty()
      : id = null,
        productCode = null,
        entityCode = null,
        username = null,
        planName = null,
        amount = null,
        sourceAccount = null,
        maturityDate = null,
        totalAmount = null,
        interestAccrued = null,
        status = null,
        amountPaid = null,
        duration = null;

  factory DepositData.fromJson(Map<String, dynamic> json) => DepositData(
        id: json["id"],
        productCode: json["productCode"],
        entityCode: json["entityCode"],
        username: json["username"],
        planName: json["planName"],
        amount: json["amount"],
        sourceAccount: json["sourceAccount"],
        maturityDate: json["maturityDate"] == null
            ? null
            : DateTime.parse(json["maturityDate"]),
        totalAmount: json["totalAmount"],
        interestAccrued: json["interestAccrued"],
        status: json["status"],
        amountPaid: json["amountPaid"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productCode": productCode,
        "entityCode": entityCode,
        "username": username,
        "planName": planName,
        "amount": amount,
        "sourceAccount": sourceAccount,
        "maturityDate": maturityDate?.toIso8601String(),
        "totalAmount": totalAmount,
        "interestAccrued": interestAccrued,
        "status": status,
        "amountPaid": amountPaid,
        "duration": duration,
      };

  @override
  String toString() => {
        "CLASS": "DepositData",
        "id": id,
        "productCode": productCode,
        "entityCode": entityCode,
        "username": username,
        "planName": planName,
        "amount": amount,
        "sourceAccount": sourceAccount,
        "maturityDate": maturityDate?.toIso8601String(),
        "totalAmount": totalAmount,
        "interestAccrued": interestAccrued,
        "status": status,
        "amountPaid": amountPaid,
        "duration": duration,
      }.toString();
}
