import 'package:equatable/equatable.dart';

class TransferResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final TransferData? data;

  TransferResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) =>
      TransferResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null ? null : TransferData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      };

  @override
  String toString() => "TransferResponse: ${toJson()}";

  @override
  List<Object?> get props => [];
}

class TransferData extends Equatable {
  final String? refNo;
  final String? paymentRef;
  final String? tranCode;
  final String? tranType;
  final String? tranUniqueRefNo;
  final String? tranDesc;
  final double? amount;
  final String? currencyCode;
  final String? narration;
  final DateTime? transactionDate;
  final String? transactionStatus;
  final String? beneficiaryName;
  final String? beneficiaryAccountNumber;
  final String? beneficiaryBank;
  final String? billerName;
  final String? senderAccountNumber;
  final String? senderName;
  final String? sessionId;
  final String? crDr;

  TransferData({
    this.refNo,
    this.paymentRef,
    this.tranCode,
    this.tranType,
    this.tranUniqueRefNo,
    this.tranDesc,
    this.amount,
    this.currencyCode,
    this.narration,
    this.transactionDate,
    this.transactionStatus,
    this.beneficiaryName,
    this.beneficiaryAccountNumber,
    this.senderAccountNumber,
    this.beneficiaryBank,
    this.billerName,
    this.senderName,
    this.sessionId,
    this.crDr,
  });

  TransferData.empty()
      : refNo = null,
        paymentRef = null,
        tranCode = null,
        tranType = null,
        tranUniqueRefNo = null,
        tranDesc = null,
        amount = null,
        currencyCode = null,
        narration = null,
        transactionDate = null,
        transactionStatus = null,
        beneficiaryName = null,
        beneficiaryAccountNumber = null,
        billerName = null,
        beneficiaryBank = null,
        senderAccountNumber = null,
        senderName = null,
        sessionId = null,
        crDr = null;

  factory TransferData.fromJson(Map<String, dynamic> json) => TransferData(
        refNo: json["refNo"],
        paymentRef: json["paymentRef"],
        tranCode: json["tranCode"],
        tranType: json["tranType"],
        tranUniqueRefNo: json["tranUniqRefNo"],
        tranDesc: json["tranDesc"],
        amount: (json['amount'] as double?) ?? 0.0,
        currencyCode: json["currencyCode"],
        narration: json["narration"],
        transactionDate: DateTime.tryParse(json["transactionDate"] ?? ''),
        transactionStatus: json["transactionStatus"],
        beneficiaryName: json["beneficiaryName"],
        beneficiaryAccountNumber: json["beneficiaryAccountNumber"],
        beneficiaryBank: json["beneficiaryBank"],
        billerName: json["billerName"],
        senderAccountNumber: json["senderAccountNumber"],
        senderName: json["senderName"],
        sessionId: json["sessionId"],
        crDr: json["crDr"],
      );

  Map<String, dynamic> toJson() => {
        "refNo": refNo,
        "paymentRef": paymentRef,
        "tranCode": tranCode,
        "tranType": tranType,
        "tranUniqueRefNo": tranUniqueRefNo,
        "tranDesc": tranDesc,
        "amount": amount,
        "currencyCode": currencyCode,
        "narration": narration,
        "transactionDate": transactionDate,
        "transactionStatus": transactionStatus,
        "beneficiaryName": beneficiaryName,
        "beneficiaryAccountNumber": beneficiaryAccountNumber,
        "beneficiaryBank": beneficiaryBank,
        "billerName": billerName,
        "senderAccountNumber": senderAccountNumber,
        "senderName": senderName,
        "sessionId": sessionId,
        "crDr": crDr,
      };

  @override
  String toString() => "TransferData: ${toJson()}";

  @override
  List<Object?> get props => [
        refNo,
        paymentRef,
        tranCode,
        tranType,
        tranUniqueRefNo,
        tranDesc,
        amount,
        currencyCode,
        narration,
        transactionDate,
        transactionStatus,
        beneficiaryName,
        beneficiaryAccountNumber,
        beneficiaryBank,
        billerName,
        senderAccountNumber,
        senderName,
        sessionId,
        crDr,
      ];
}
