class BaLookUpDataResponse {
  final String responseCode;
  final String responseMessage;
  final List<LookupDataInfo>? response;

  BaLookUpDataResponse({
    required this.responseCode,
    required this.responseMessage,
    this.response,
  });

  factory BaLookUpDataResponse.fromJson(Map<String, dynamic> json) =>
      BaLookUpDataResponse(
        responseCode: json['responseCode'] as String,
        responseMessage: json['responseMessage'] as String,
        response: json["response"] == null
            ? null
            : (json["response"] as List)
                .map((e) => LookupDataInfo.fromJson(e))
                .toList(),
      );
}

class LookupDataInfo {
  final int? id;
  final String? categoryCode;
  final String? lookupCode;
  final String? lookupName;
  final String? lookupDesc;
  final String? usageAccess;
  final String? status;
  final String? entityCode;
  final String? countryCode;

  LookupDataInfo({
    this.id,
    this.categoryCode,
    this.lookupCode,
    this.lookupName,
    this.lookupDesc,
    this.usageAccess,
    this.status,
    this.entityCode,
    this.countryCode,
  });

  factory LookupDataInfo.fromJson(Map<String, dynamic> json) => LookupDataInfo(
        id: json["id"],
        categoryCode: json["categoryCode"],
        lookupCode: json["lookupCode"],
        lookupName: json["lookupName"],
        lookupDesc: json["lookupDesc"],
        usageAccess: json["usageAccess"],
        status: json["status"],
        entityCode: json["entityCode"],
        countryCode: json["countryCode"],
      );
}
