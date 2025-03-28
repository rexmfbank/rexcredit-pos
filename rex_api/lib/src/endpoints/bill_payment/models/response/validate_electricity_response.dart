import 'dart:convert';

class ValidateElectricityResponse {
  String? responseCode;
  String? responseMessage;
  ValidateElectricityData? data;

  ValidateElectricityResponse({
    this.responseCode,
    this.responseMessage,
    this.data,
  });

  ValidateElectricityResponse copyWith({
    String? responseCode,
    String? responseMessage,
    ValidateElectricityData? data,
  }) =>
      ValidateElectricityResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory ValidateElectricityResponse.fromRawJson(String str) => ValidateElectricityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateElectricityResponse.fromJson(Map<String, dynamic> json) => ValidateElectricityResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : ValidateElectricityData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };
}

class ValidateElectricityData {
  String? meterNo;
  String? accountNo;
  String? customerName;
  String? customerAddress;
  String? customerDistrict;
  String? phoneNumber;
  String? minimumAmount;
  String? type;
  String? disco;
  String? status;

  ValidateElectricityData({
    this.meterNo,
    this.accountNo,
    this.customerName,
    this.customerAddress,
    this.customerDistrict,
    this.phoneNumber,
    this.minimumAmount,
    this.type,
    this.disco,
    this.status,
  });

  ValidateElectricityData copyWith({
    String? meterNo,
    String? accountNo,
    String? customerName,
    String? customerAddress,
    String? customerDistrict,
    String? phoneNumber,
    String? minimumAmount,
    String? type,
    String? disco,
    String? status,
  }) =>
      ValidateElectricityData(
        meterNo: meterNo ?? this.meterNo,
        accountNo: accountNo ?? this.accountNo,
        customerName: customerName ?? this.customerName,
        customerAddress: customerAddress ?? this.customerAddress,
        customerDistrict: customerDistrict ?? this.customerDistrict,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        minimumAmount: minimumAmount ?? this.minimumAmount,
        type: type ?? this.type,
        disco: disco ?? this.disco,
        status: status ?? this.status,
      );

  factory ValidateElectricityData.fromRawJson(String str) => ValidateElectricityData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateElectricityData.fromJson(Map<String, dynamic> json) => ValidateElectricityData(
    meterNo: json["meterNo"],
    accountNo: json["accountNo"],
    customerName: json["customerName"],
    customerAddress: json["customerAddress"],
    customerDistrict: json["customerDistrict"],
    phoneNumber: json["phoneNumber"],
    minimumAmount: json["minimumAmount"],
    type: json["type"],
    disco: json["disco"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "meterNo": meterNo,
    "accountNo": accountNo,
    "customerName": customerName,
    "customerAddress": customerAddress,
    "customerDistrict": customerDistrict,
    "phoneNumber": phoneNumber,
    "minimumAmount": minimumAmount,
    "type": type,
    "disco": disco,
    "status": status,
  };
}
