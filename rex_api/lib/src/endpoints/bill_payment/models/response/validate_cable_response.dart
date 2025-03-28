import 'dart:convert';

class ValidateCableResponse {
  String responseCode;
  String responseMessage;
  ValidateCableData? data;

  ValidateCableResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  ValidateCableResponse copyWith({
    String? responseCode,
    String? responseMessage,
    ValidateCableData? data,
  }) =>
      ValidateCableResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory ValidateCableResponse.fromRawJson(String str) => ValidateCableResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateCableResponse.fromJson(Map<String, dynamic> json) => ValidateCableResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : ValidateCableData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };
}

class ValidateCableData {
  String? status;
  String? message;
  String? type;
  String? smartCardNo;
  String? customerName;
  String? accountStatus;
  int? dueDate;
  int? invoicePeriod;
  int? customerNumber;
  String? balance;
  String? customerType;
  List<ValidateCableProduct>? product;

  ValidateCableData({
    this.status,
    this.message,
    this.type,
    this.smartCardNo,
    this.customerName,
    this.accountStatus,
    this.dueDate,
    this.invoicePeriod,
    this.customerNumber,
    this.balance,
    this.customerType,
    this.product,
  });

  ValidateCableData copyWith({
    String? status,
    String? message,
    String? type,
    String? smartCardNo,
    String? customerName,
    String? accountStatus,
    int? dueDate,
    int? invoicePeriod,
    int? customerNumber,
    String? balance,
    String? customerType,
    List<ValidateCableProduct>? product,
  }) =>
      ValidateCableData(
        status: status ?? this.status,
        message: message ?? this.message,
        type: type ?? this.type,
        smartCardNo: smartCardNo ?? this.smartCardNo,
        customerName: customerName ?? this.customerName,
        accountStatus: accountStatus ?? this.accountStatus,
        dueDate: dueDate ?? this.dueDate,
        invoicePeriod: invoicePeriod ?? this.invoicePeriod,
        customerNumber: customerNumber ?? this.customerNumber,
        balance: balance ?? this.balance,
        customerType: customerType ?? this.customerType,
        product: product ?? this.product,
      );

  factory ValidateCableData.fromRawJson(String str) => ValidateCableData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateCableData.fromJson(Map<String, dynamic> json) => ValidateCableData(
    status: json["status"],
    message: json["message"],
    type: json["type"],
    smartCardNo: json["smartCardNo"],
    customerName: json["customerName"],
    accountStatus: json["accountStatus"],
    dueDate: json["dueDate"],
    invoicePeriod: json["invoicePeriod"],
    customerNumber: json["customerNumber"],
    balance: json["balance"],
    customerType: json["custormerType"],
    product: json["product"] == null ? [] : List<ValidateCableProduct>.from(json["product"]!.map((x) => ValidateCableProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "type": type,
    "smartCardNo": smartCardNo,
    "customerName": customerName,
    "accountStatus": accountStatus,
    "dueDate": dueDate,
    "invoicePeriod": invoicePeriod,
    "customerNumber": customerNumber,
    "balance": balance,
    "custormerType": customerType,
    "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
  };
}

class ValidateCableProduct {
  String? name;
  String? code;
  int? month;
  num? price;
  int? period;

  ValidateCableProduct({
    this.name,
    this.code,
    this.month,
    this.price,
    this.period,
  });

  ValidateCableProduct copyWith({
    String? name,
    String? code,
    int? month,
    num? price,
    int? period,
  }) =>
      ValidateCableProduct(
        name: name ?? this.name,
        code: code ?? this.code,
        month: month ?? this.month,
        price: price ?? this.price,
        period: period ?? this.period,
      );

  factory ValidateCableProduct.fromRawJson(String str) => ValidateCableProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateCableProduct.fromJson(Map<String, dynamic> json) => ValidateCableProduct(
    name: json["name"],
    code: json["code"],
    month: json["month"],
    price: json["price"],
    period: json["period"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "month": month,
    "price": price,
    "period": period,
  };
}