import 'dart:convert';

class ValidateBillRequest {
  String? entityCode;
  String? billerCode;
  String? productCode;
  String? referenceNo;
  String? amount;
  String? countryCode;
  String? serviceProvider;

  ValidateBillRequest({
    this.entityCode,
    this.billerCode,
    this.productCode,
    this.referenceNo,
    this.amount,
    this.countryCode,
    this.serviceProvider,
  });

  ValidateBillRequest copyWith({
    String? entityCode,
    String? billerCode,
    String? productCode,
    String? referenceNo,
    String? amount,
    String? countryCode,
    String? serviceProvider,
  }) =>
      ValidateBillRequest(
        entityCode: entityCode ?? this.entityCode,
        billerCode: billerCode ?? this.billerCode,
        productCode: productCode ?? this.productCode,
        referenceNo: referenceNo ?? this.referenceNo,
        amount: amount ?? this.amount,
        countryCode: countryCode ?? this.countryCode,
        serviceProvider: serviceProvider ?? this.serviceProvider,
      );

  factory ValidateBillRequest.fromRawJson(String str) => ValidateBillRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateBillRequest.fromJson(Map<String, dynamic> json) => ValidateBillRequest(
    entityCode: json["entityCode"],
    billerCode: json["billerCode"],
    productCode: json["productCode"],
    referenceNo: json["referenceNo"],
    amount: json["amount"],
    countryCode: json["countryCode"],
    serviceProvider: json["serviceProvider"],
  );

  Map<String, dynamic> toJson() => {
    "entityCode": entityCode,
    "billerCode": billerCode,
    "productCode": productCode,
    "referenceNo": referenceNo,
    "amount": amount,
    "countryCode": countryCode,
    "serviceProvider": serviceProvider,
  };
}
