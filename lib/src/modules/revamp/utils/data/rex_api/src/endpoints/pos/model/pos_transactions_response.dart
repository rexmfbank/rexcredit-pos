import 'package:equatable/equatable.dart';

class PosTransactionsResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final List<PosTransactionsResponseData> data;
  final int pageIndex;
  final int pageSize;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int totalContent;

  const PosTransactionsResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
    required this.pageIndex,
    required this.pageSize,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.totalContent,
  });

  factory PosTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return PosTransactionsResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: List.from(
        json['data'].map((e) => PosTransactionsResponseData.fromJson(e)),
      ),
      pageIndex: json['pageIndex'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
      totalContent: json['totalContent'],
    );
  }

  @override
  String toString() =>
      {
        "CLASS": "PosTransactions",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}

class PosTransactionsResponseData extends Equatable {
  final String? tranCode;
  final String? tranType;
  final String? tranUniqRefNo;
  final String? tranRefNo;
  final String? tranDesc;
  final double? amount;
  final String? responseCode;
  final String? responseMessage;
  final String? cbaReferenceNo;
  final String? paymentRspCode;
  final String? paymentRspMsg;
  final String? paymentRefNo;
  final String? currencyCode;
  final String? narration;
  final String? beneficiaryBank;
  final String? beneficiaryAccountNo;
  final String? sourceAccount;
  final String? tranDate;
  final String? beneficiaryBankCode;
  final String? beneficiaryName;
  final String? token;
  final String? sessionId;
  final String? status;
  final String? senderName;
  final String? paymentStatus;
  final String? aid;
  final String? crDr;
  final String? merchantName;
  final String? rrn;
  final String? stan;
  final String? terminalId;
  final String? merchantId;
  final String? senderAccountNumber;

  const PosTransactionsResponseData({
    this.tranCode,
    this.tranType,
    this.tranUniqRefNo,
    this.tranRefNo,
    this.tranDesc,
    this.amount,
    this.responseCode,
    this.responseMessage,
    this.cbaReferenceNo,
    this.paymentRspCode,
    this.paymentRspMsg,
    this.paymentRefNo,
    this.currencyCode,
    this.narration,
    this.beneficiaryBank,
    this.beneficiaryAccountNo,
    this.sourceAccount,
    this.tranDate,
    this.beneficiaryBankCode,
    this.beneficiaryName,
    this.token,
    this.sessionId,
    this.status,
    this.senderName,
    this.paymentStatus,
    this.aid,
    this.crDr,
    this.merchantName,
    this.rrn,
    this.stan,
    this.terminalId,
    this.merchantId,
    this.senderAccountNumber,
  });

  const PosTransactionsResponseData.empty()
    : tranCode = null,
      tranType = null,
      tranUniqRefNo = null,
      tranRefNo = null,
      tranDesc = null,
      amount = null,
      responseCode = null,
      responseMessage = null,
      cbaReferenceNo = null,
      paymentRspCode = null,
      paymentRspMsg = null,
      paymentRefNo = null,
      currencyCode = null,
      narration = null,
      beneficiaryBank = null,
      beneficiaryAccountNo = null,
      sourceAccount = null,
      tranDate = null,
      beneficiaryBankCode = null,
      beneficiaryName = null,
      token = null,
      sessionId = null,
      status = null,
      senderName = null,
      paymentStatus = null,
      aid = null,
      crDr = null,
      merchantName = null,
      rrn = null,
      stan = null,
      terminalId = null,
      merchantId = null,
      senderAccountNumber = null;

  factory PosTransactionsResponseData.fromJson(Map<String, dynamic> json) {
    return PosTransactionsResponseData(
      tranCode: json['tranCode'],
      tranType: json['tranType'],
      tranUniqRefNo: json['tranUniqRefNo'],
      tranRefNo: json['tranRefNo'],
      tranDesc: json['tranDesc'],
      amount: (json['amount']),
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      cbaReferenceNo: json['cbaReferenceNo'],
      paymentRspCode: json['paymentRspCode'],
      paymentRspMsg: json['paymentRspMsg'],
      paymentRefNo: json['paymentRefNo'],
      currencyCode: json['currencyCode'],
      narration: json['narration'],
      beneficiaryBank: json['beneficiaryBank'],
      beneficiaryAccountNo: json['beneficiaryAccountNo'],
      sourceAccount: json['sourceAccount'],
      tranDate: json['tranDate'],
      beneficiaryBankCode: json['beneficiaryBankCode'],
      beneficiaryName: json['beneficiaryName'],
      token: json['token'],
      sessionId: json['sessionId'],
      status: json['status'],
      senderName: json['senderName'],
      paymentStatus: json['paymentStatus'],
      aid: json['aid'],
      crDr: json['crDr'],
      merchantName: json['merchantName'],
      rrn: json['rrn'],
      stan: json['stan'],
      terminalId: json['terminalId'],
      merchantId: json['merchantId'],
      senderAccountNumber: json['senderAccountNumber'],
    );
  }

  @override
  String toString() =>
      {
        "tranCode": tranCode,
        "tranType": tranType,
        "tranUniqRefNo": tranUniqRefNo,
        "tranRefNo": tranRefNo,
        "tranDesc": tranDesc,
        "amount": amount,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "cbaReferenceNo": cbaReferenceNo,
        "paymentRspCode": paymentRspCode,
        "paymentRspMsg": paymentRspMsg,
        "paymentRefNo": paymentRefNo,
        "currencyCode": currencyCode,
        "narration": narration,
        "beneficiaryBank": beneficiaryBank,
        "beneficiaryAccountNo": beneficiaryAccountNo,
        "sourceAccount": sourceAccount,
        "tranDate": tranDate,
        "beneficiaryBankCode": beneficiaryBankCode,
        "beneficiaryName": beneficiaryName,
        "token": token,
        "sessionId": sessionId,
        "status": status,
        "senderName": senderName,
        "paymentStatus": paymentStatus,
      }.toString();

  @override
  List<Object?> get props => [
    tranCode,
    tranType,
    tranUniqRefNo,
    tranRefNo,
    tranDesc,
    amount,
    responseCode,
    responseMessage,
    cbaReferenceNo,
    paymentRspCode,
    paymentRspMsg,
    paymentRefNo,
    currencyCode,
    narration,
    beneficiaryBank,
    beneficiaryAccountNo,
    sourceAccount,
    tranDate,
    beneficiaryBankCode,
    beneficiaryName,
    token,
    sessionId,
    status,
    senderName,
    paymentStatus,
    aid,
    merchantName,
    rrn,
    stan,
    terminalId,
    merchantId,
    senderAccountNumber,
  ];
}
