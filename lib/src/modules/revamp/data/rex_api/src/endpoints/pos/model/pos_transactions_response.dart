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
  final String? tranRefNo;
  final num? amount;
  final String? narration;
  final String? beneficiaryBank;
  final String? beneficiaryAccountNo;
  final String? tranDate;
  final String? status;
  final String? senderName;
  final String? aid;
  final String? rrn;
  final String? stan;
  final String? terminalId;

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
    this.aid,
    this.rrn,
    this.stan,
    this.terminalId,
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
      aid = null,
      rrn = null,
      stan = null,
      terminalId = null;

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
      aid: json['aid'],
      rrn: json['rrn'],
      stan: json['stan'],
      terminalId: json['terminalID'],
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
        "aid": aid,
        "rrn": rrn,
        "stan": stan,
        "terminalId": terminalId,
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
    aid,
    rrn,
    stan,
    terminalId,
  ];
}
