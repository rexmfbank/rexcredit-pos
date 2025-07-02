import 'dart:convert';

class ValidateElectricityRequest {
  String? serviceCode;
  String? disco;
  String? meterNo;
  String? type;

  ValidateElectricityRequest({
    this.serviceCode,
    this.disco,
    this.meterNo,
    this.type,
  });

  ValidateElectricityRequest copyWith({
    String? serviceCode,
    String? disco,
    String? meterNo,
    String? type,
  }) =>
      ValidateElectricityRequest(
        serviceCode: serviceCode ?? this.serviceCode,
        disco: disco ?? this.disco,
        meterNo: meterNo ?? this.meterNo,
        type: type ?? this.type,
      );

  factory ValidateElectricityRequest.fromRawJson(String str) => ValidateElectricityRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateElectricityRequest.fromJson(Map<String, dynamic> json) => ValidateElectricityRequest(
    serviceCode: json["serviceCode"],
    disco: json["disco"],
    meterNo: json["meterNo"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "serviceCode": serviceCode,
    "disco": disco,
    "meterNo": meterNo,
    "type": type,
  };
}
