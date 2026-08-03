import 'package:equatable/equatable.dart';

class PosTransactionsRequest extends Equatable {
  final String orderType;
  final int pageSize;
  final int pageIndex;
  final bool isSimple;
  final String? startDate;
  final String? endDate;
  final String? transactionType; // credit, debit, refund
  final String? tranDesc;
  final String? status; // successful, failed, pending

  const PosTransactionsRequest({
    required this.orderType,
    required this.pageSize,
    required this.pageIndex,
    required this.isSimple,
    this.startDate,
    this.endDate,
    this.transactionType,
    this.tranDesc,
    this.status,
  });

  Map<String, dynamic> toJson() {
    if (isSimple) {
      return {
        "orderType": orderType,
        "pageSize": pageSize,
        "pageIndex": pageIndex,
      };
    }
    return {
      "orderType": orderType,
      "pageSize": pageSize,
      "pageIndex": pageIndex,
      "startDate": startDate ?? '',
      "endDate": endDate ?? '',
      "transactionType": transactionType ?? '',
      "status": status ?? '',
      "tranDesc": tranDesc ?? '',
    };
  }

  @override
  List<Object?> get props => [
    orderType,
    pageSize,
    pageIndex,
    startDate,
    endDate,
    transactionType,
    status,
    tranDesc,
  ];
}

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
  final String? tranRefNo;
  final num? amount;
  final String? narration;
  final String? beneficiaryBank;
  final String? beneficiaryAccountNo;
  final String? tranDate;
  final String? status;
  final String? senderName;
  final String? senderAcctNo;
  final String? aid;
  final String? rrn;
  final String? stan;
  final String? terminalId;
  final String? posType;
  final String? merchantCode;
  final String? merchantNuban;
  final String? transactionType;

  const PosTransactionsResponseData({
    this.tranCode,
    this.tranType,
    this.tranRefNo,
    this.amount,
    this.narration,
    this.beneficiaryBank,
    this.beneficiaryAccountNo,
    this.tranDate,
    this.status,
    this.senderName,
    this.senderAcctNo,
    this.aid,
    this.rrn,
    this.stan,
    this.terminalId,
    this.posType,
    this.merchantCode,
    this.merchantNuban,
    this.transactionType,
  });

  const PosTransactionsResponseData.empty()
    : tranCode = null,
      tranType = null,
      tranRefNo = null,
      amount = null,
      narration = null,
      beneficiaryBank = null,
      beneficiaryAccountNo = null,
      tranDate = null,
      status = null,
      senderName = null,
      senderAcctNo = null,
      aid = null,
      rrn = null,
      stan = null,
      terminalId = null,
      posType = null,
      merchantCode = null,
      merchantNuban = null,
      transactionType = null;

  factory PosTransactionsResponseData.fromJson(Map<String, dynamic> json) {
    return PosTransactionsResponseData(
      tranCode: json['tranCode'],
      tranType: json['tranType'],
      tranRefNo: json['tranRefNo'],
      amount: (json['amount']),
      narration: json['narration'],
      beneficiaryBank: json['beneficiaryBank'],
      beneficiaryAccountNo: json['beneficiaryAccountNo'],
      tranDate: json['tranDate'],
      status: json['status'],
      senderName: json['senderName'],
      senderAcctNo: json['senderAccountNo'],
      aid: json['aid'],
      rrn: json['rrn'],
      stan: json['stan'],
      terminalId: json['terminalID'],
      posType: json['posType'],
      merchantCode: json['merchantCode'],
      merchantNuban: json['merchantNuban'],
      transactionType: json['transactionType'],
    );
  }

  @override
  String toString() =>
      {
        "tranCode": tranCode,
        "tranType": tranType,
        "tranRefNo": tranRefNo,
        "amount": amount,
        "narration": narration,
        "beneficiaryBank": beneficiaryBank,
        "beneficiaryAccountNo": beneficiaryAccountNo,
        "tranDate": tranDate,
        "status": status,
        "senderName": senderName,
        "senderAcctNo": senderAcctNo,
        "aid": aid,
        "rrn": rrn,
        "stan": stan,
        "terminalId": terminalId,
        "posType": posType,
        "merchantCode": merchantCode,
        "merchantNuban": merchantNuban,
        "transactionType": transactionType,
      }.toString();

  @override
  List<Object?> get props => [
    tranCode,
    tranType,
    tranRefNo,
    amount,
    narration,
    beneficiaryBank,
    beneficiaryAccountNo,
    tranDate,
    status,
    senderName,
    senderAcctNo,
    aid,
    rrn,
    stan,
    terminalId,
    posType,
    merchantCode,
    merchantNuban,
    transactionType,
  ];
}
