import 'dart:convert';

class ValidateBillResponse {
  String responseCode;
  String responseMessage;
  ValidateBillData? data;

  ValidateBillResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  ValidateBillResponse copyWith({
    String? responseCode,
    String? responseMessage,
    ValidateBillData? data,
  }) =>
      ValidateBillResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory ValidateBillResponse.fromRawJson(String str) => ValidateBillResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateBillResponse.fromJson(Map<String, dynamic> json) => ValidateBillResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : ValidateBillData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };
}

class ValidateBillData {
  String? billerCode;
  String? productCode;
  String? customerName;
  String? customerRef;
  String? billDetail;
  num? amount;
  String? partialAllowed;
  String? amountType;
  String? status;
  String? mobileNo;
  String? emailId;
  String? customerAddress;
  num? fee;
  num? agentCommission;
  String? ccyCode;
  String? paymentDataList;

  ValidateBillData({
    this.billerCode,
    this.productCode,
    this.customerName,
    this.customerRef,
    this.billDetail,
    this.amount,
    this.partialAllowed,
    this.amountType,
    this.status,
    this.mobileNo,
    this.emailId,
    this.customerAddress,
    this.fee,
    this.agentCommission,
    this.ccyCode,
    this.paymentDataList,
  });

  ValidateBillData copyWith({
    String? billerCode,
    String? productCode,
    String? customerName,
    String? customerRef,
    String? billDetail,
    num? amount,
    String? partialAllowed,
    String? amountType,
    String? status,
    String? mobileNo,
    String? emailId,
    String? customerAddress,
    num? fee,
    num? agentCommission,
    String? ccyCode,
    String? paymentDataList,
  }) =>
      ValidateBillData(
        billerCode: billerCode ?? this.billerCode,
        productCode: productCode ?? this.productCode,
        customerName: customerName ?? this.customerName,
        customerRef: customerRef ?? this.customerRef,
        billDetail: billDetail ?? this.billDetail,
        amount: amount ?? this.amount,
        partialAllowed: partialAllowed ?? this.partialAllowed,
        amountType: amountType ?? this.amountType,
        status: status ?? this.status,
        mobileNo: mobileNo ?? this.mobileNo,
        emailId: emailId ?? this.emailId,
        customerAddress: customerAddress ?? this.customerAddress,
        fee: fee ?? this.fee,
        agentCommission: agentCommission ?? this.agentCommission,
        ccyCode: ccyCode ?? this.ccyCode,
        paymentDataList: paymentDataList ?? this.paymentDataList,
      );

  factory ValidateBillData.fromRawJson(String str) => ValidateBillData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateBillData.fromJson(Map<String, dynamic> json) => ValidateBillData(
    billerCode: json["billerCode"],
    productCode: json["productCode"],
    customerName: json["customerName"],
    customerRef: json["customerRef"],
    billDetail: json["billDetail"],
    amount: json["amount"],
    partialAllowed: json["partialAllowed"],
    amountType: json["amountType"],
    status: json["status"],
    mobileNo: json["mobileNo"],
    emailId: json["emailID"],
    customerAddress: json["customerAddress"],
    fee: json["fee"],
    agentCommission: json["agentCommission"],
    ccyCode: json["ccyCode"],
    paymentDataList: json["paymentDataList"],
  );

  Map<String, dynamic> toJson() => {
    "billerCode": billerCode,
    "productCode": productCode,
    "customerName": customerName,
    "customerRef": customerRef,
    "billDetail": billDetail,
    "amount": amount,
    "partialAllowed": partialAllowed,
    "amountType": amountType,
    "status": status,
    "mobileNo": mobileNo,
    "emailID": emailId,
    "customerAddress": customerAddress,
    "fee": fee,
    "agentCommission": agentCommission,
    "ccyCode": ccyCode,
    "paymentDataList": paymentDataList,
  };
}
