class CreateDepositRequest {
  final String? amount;
  final String? duration;
  final String? planName;
  final String? interestType;
  final String? fundingSource;
  final String? fundingSourceId;
  final String? geoLocation;
  final String? externalRefNo;

  CreateDepositRequest({
    this.amount,
    this.duration,
    this.planName,
    this.interestType,
    this.fundingSource,
    this.fundingSourceId,
    this.geoLocation,
    this.externalRefNo,
  });

  factory CreateDepositRequest.fromJson(Map<String, dynamic> json) =>
      CreateDepositRequest(
        amount: json["amount"],
        duration: json["duration"],
        planName: json["planName"],
        interestType: json["interestType"],
        fundingSource: json["fundingSource"],
        fundingSourceId: json["fundingSourceId"],
        geoLocation: json['geolocation'],
        externalRefNo: json['externalRefNo'],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "duration": duration,
        "planName": planName,
        "interestType": interestType,
        "fundingSource": fundingSource,
        "fundingSourceId": fundingSourceId,
        "geolocation": geoLocation,
        "externalRefNo": externalRefNo,
      };

  @override
  String toString() => {
        "CLASS": "CreateDepositRequest",
        "amount": amount,
        "duration": duration,
        "planName": planName,
        "interestType": interestType,
        "fundingSource": fundingSource,
        "fundingSourceId": fundingSourceId,
        "geolocation": geoLocation,
        "externalRefNo": externalRefNo,
      }.toString();
}
