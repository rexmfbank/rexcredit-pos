import 'dart:convert';

class FetchBeneficiaryResponse {
  String responseCode;
  String responseMessage;
  String? entityCode;
  List<BeneficiaryData>? data;

  FetchBeneficiaryResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  FetchBeneficiaryResponse copyWith({
    String? responseCode,
    String? responseMessage,
    String? entityCode,
    List<BeneficiaryData>? data,
  }) =>
      FetchBeneficiaryResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        entityCode: entityCode ?? this.entityCode,
        data: data ?? this.data,
      );

  factory FetchBeneficiaryResponse.fromRawJson(String str) =>
      FetchBeneficiaryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FetchBeneficiaryResponse.fromJson(Map<String, dynamic> json) =>
      FetchBeneficiaryResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null
            ? []
            : List<BeneficiaryData>.from(
                json["data"]!.map((x) => BeneficiaryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BeneficiaryData {
  String? beneficiaryAccount;
  String? beneficiaryMobile;
  String? beneficiaryName;
  String? beneficiaryDetail;
  String? finEntityCode;
  String? finEntityName;
  String? tranCode;
  String? id;

  BeneficiaryData({
    this.beneficiaryAccount,
    this.beneficiaryMobile,
    this.beneficiaryName,
    this.beneficiaryDetail,
    this.finEntityCode,
    this.finEntityName,
    this.tranCode,
    this.id,
  });

  BeneficiaryData copyWith({
    String? beneficiaryAccount,
    String? beneficiaryMobile,
    String? beneficiaryName,
    String? beneficiaryDetail,
    String? finEntityCode,
    String? finEntityName,
    String? tranCode,
    String? id,
  }) =>
      BeneficiaryData(
        beneficiaryAccount: beneficiaryAccount ?? this.beneficiaryAccount,
        beneficiaryMobile: beneficiaryMobile ?? this.beneficiaryMobile,
        beneficiaryName: beneficiaryName ?? this.beneficiaryName,
        beneficiaryDetail: beneficiaryDetail ?? this.beneficiaryDetail,
        finEntityCode: finEntityCode ?? this.finEntityCode,
        finEntityName: finEntityName ?? this.finEntityName,
        tranCode: tranCode ?? this.tranCode,
        id: id ?? this.id,
      );

  factory BeneficiaryData.fromRawJson(String str) =>
      BeneficiaryData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BeneficiaryData.fromJson(Map<String, dynamic> json) =>
      BeneficiaryData(
        beneficiaryAccount: json["beneficiaryAccount"],
        beneficiaryMobile: json["beneficiaryMobile"],
        beneficiaryName: json["beneficiaryName"],
        beneficiaryDetail: json["beneficiaryDetail"],
        finEntityCode: json["finEntityCode"],
        finEntityName: json["finEntityName"],
        tranCode: json["tranCode"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "beneficiaryAccount": beneficiaryAccount,
        "beneficiaryMobile": beneficiaryMobile,
        "beneficiaryName": beneficiaryName,
        "beneficiaryDetail": beneficiaryDetail,
        "finEntityCode": finEntityCode,
        "id": id,
      };
}
