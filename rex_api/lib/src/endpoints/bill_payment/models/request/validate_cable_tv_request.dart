import 'dart:convert';

class ValidateCableTvRequest {
  String? serviceCode;
  String? smartCardNo;
  String? type;

  ValidateCableTvRequest({
    this.serviceCode,
    this.smartCardNo,
    this.type,
  });

  ValidateCableTvRequest copyWith({
    String? serviceCode,
    String? smartCardNo,
    String? type,
  }) =>
      ValidateCableTvRequest(
        serviceCode: serviceCode ?? this.serviceCode,
        smartCardNo: smartCardNo ?? this.smartCardNo,
        type: type ?? this.type,
      );

  factory ValidateCableTvRequest.fromRawJson(String str) => ValidateCableTvRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateCableTvRequest.fromJson(Map<String, dynamic> json) => ValidateCableTvRequest(
    serviceCode: json["serviceCode"],
    smartCardNo: json["smartCardNo"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "serviceCode": serviceCode,
    "smartCardNo": smartCardNo,
    "type": type,
  };
}
