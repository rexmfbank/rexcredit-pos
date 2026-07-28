import 'package:equatable/equatable.dart';

class TransactionQueryResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final TransactionQueryData data;

  const TransactionQueryResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory TransactionQueryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionQueryResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: TransactionQueryData.fromJson(json['data']),
    );
  }

  @override
  String toString() =>
      {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}

class TransactionQueryData extends Equatable {
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
  final String? posType;

  const TransactionQueryData({
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
    this.posType,
  });

  const TransactionQueryData.empty()
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
      terminalId = null,
      posType = null;

  factory TransactionQueryData.fromJson(Map<String, dynamic> json) {
    return TransactionQueryData(
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
      posType: json['posType'],
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
        "posType": posType,
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
    posType,
  ];
}
