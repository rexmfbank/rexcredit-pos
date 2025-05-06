import 'dart:convert';

class PostBillPaymentResponse {
  String responseCode;
  String responseMessage;
  PostBillPaymentData? data;

  PostBillPaymentResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  PostBillPaymentResponse copyWith({
    String? responseCode,
    String? responseMessage,
    PostBillPaymentData? data,
  }) =>
      PostBillPaymentResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory PostBillPaymentResponse.fromRawJson(String str) => PostBillPaymentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostBillPaymentResponse.fromJson(Map<String, dynamic> json) => PostBillPaymentResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : PostBillPaymentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };
}

class PostBillPaymentData {
  String? id;
  String? refNo;
  String? amount;

  PostBillPaymentData({
    this.id,
    this.refNo,
    this.amount,
  });

  PostBillPaymentData copyWith({
    String? id,
    String? refNo,
    String? amount,
  }) =>
      PostBillPaymentData(
        id: id ?? this.id,
        refNo: refNo ?? this.refNo,
        amount: amount ?? this.amount,
      );

  factory PostBillPaymentData.fromRawJson(String str) => PostBillPaymentData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostBillPaymentData.fromJson(Map<String, dynamic> json) => PostBillPaymentData(
    id: json["id"],
    refNo: json["refNo"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "refNo": refNo,
    "amount": amount,
  };
}
