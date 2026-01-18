import 'package:equatable/equatable.dart';

class PosNotification extends Equatable {
  final String amount;
  final String terminalSerialNo;
  final String rrn;
  final String stan;
  final String invoiceId;

  const PosNotification({
    required this.amount,
    required this.terminalSerialNo,
    required this.rrn,
    required this.stan,
    required this.invoiceId,
  });

  factory PosNotification.fromJson(Map<String, dynamic> json) {
    return PosNotification(
      amount: json['amount'],
      terminalSerialNo: json['terminalSerialNo'],
      rrn: json['rrn'],
      stan: json['stan'],
      invoiceId: json['invoiceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'terminalSerialNo': terminalSerialNo,
      'rrn': rrn,
      'stan': stan,
      'invoiceId': invoiceId,
    };
  }

  @override
  String toString() {
    return "PosNotification:: ${toJson()}";
  }

  @override
  List<Object?> get props => [amount, terminalSerialNo, rrn, stan, invoiceId];
}

class InTransferData extends Equatable {
  final String amount;
  final String tranCode;
  final String tranType;
  final int tranUniqRefNo;
  final String narration;
  final String beneficiaryBank;
  final String beneficiaryAccountNo;
  final String tranDate;
  final String beneficiaryName;
  final String sessionId;
  final String status;
  final String senderName;
  final String senderAccountNumber;

  const InTransferData({
    required this.amount,
    required this.tranCode,
    required this.tranType,
    required this.tranUniqRefNo,
    required this.narration,
    required this.beneficiaryBank,
    required this.beneficiaryAccountNo,
    required this.tranDate,
    required this.beneficiaryName,
    required this.sessionId,
    required this.status,
    required this.senderName,
    required this.senderAccountNumber,
  });

  factory InTransferData.fromJson(Map<String, dynamic> json) => InTransferData(
    amount: json['amount'],
    tranCode: json['tranCode'],
    tranType: json['tranType'],
    tranUniqRefNo: json['tranUniqRefNo'],
    narration: json['narration'],
    beneficiaryBank: json['beneficiaryBank'],
    beneficiaryAccountNo: json['beneficiaryAccountNo'],
    tranDate: json['tranDate'],
    beneficiaryName: json['beneficiaryName'],
    sessionId: json['sessionId'],
    status: json['status'],
    senderName: json['senderName'],
    senderAccountNumber: json['senderAccountNumber'],
  );

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'tranCode': tranCode,
    'tranType': tranType,
    'tranUniqRefNo': tranUniqRefNo,
    'narration': narration,
    'beneficiaryBank': beneficiaryBank,
    'beneficiaryAccountNo': beneficiaryAccountNo,
    'tranDate': tranDate,
    'beneficiaryName': beneficiaryName,
    'sessionId': sessionId,
    'status': status,
    'senderName': senderName,
    'senderAccountNumber': senderAccountNumber,
  };

  @override
  String toString() => "InTransferData:: ${toJson()}";

  @override
  List<Object?> get props => [
    amount,
    tranCode,
    tranType,
    tranUniqRefNo,
    narration,
    beneficiaryBank,
    beneficiaryAccountNo,
    tranDate,
    beneficiaryName,
    sessionId,
    status,
    senderName,
    senderAccountNumber,
  ];
}
