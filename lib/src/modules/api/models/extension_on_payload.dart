import 'package:rex_app/src/modules/api/models/transaction_query_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

extension TransactionX on Transaction {
  PrintObjTransaction toPrintObj() {
    return PrintObjTransaction(
      tranCode: '',
      tranType: '',
      tranRefNo: reference,
      amount: num.tryParse(transactionAmount ?? ''),
      narration: transactionDescription,
      beneficiaryBank: '',
      beneficiaryAccountNo: '',
      tranDate: transactionDate?.toIso8601String(),
      status: statusId,
      senderName: '',
      aid: '',
      rrn: '',
      stan: '',
      terminalId: '',
      posType: transactionDescription,
    );
  }
}

extension TransactionQueryDataX on TransactionQueryData {
  PrintObjTransaction toPrintObj() {
    return PrintObjTransaction(
      tranCode: tranCode,
      tranType: tranType,
      tranRefNo: tranRefNo,
      amount: amount,
      narration: narration,
      beneficiaryBank: beneficiaryBank,
      beneficiaryAccountNo: beneficiaryAccountNo,
      tranDate: tranDate,
      status: status,
      senderName: senderName,
      aid: aid,
      rrn: rrn,
      stan: stan,
      terminalId: terminalId,
      posType: posType,
    );
  }
}

extension PosTransactionResponseDataX on PosTransactionsResponseData {
  PrintObjTransaction toPrintObj() {
    return PrintObjTransaction(
      tranCode: tranCode,
      tranType: tranType,
      tranRefNo: tranRefNo,
      amount: amount,
      narration: narration,
      beneficiaryBank: beneficiaryBank,
      beneficiaryAccountNo: beneficiaryAccountNo,
      tranDate: tranDate,
      status: status,
      senderName: senderName,
      aid: aid,
      rrn: rrn,
      stan: stan,
      terminalId: terminalId,
      posType: posType,
    );
  }
}

class PrintObjTransaction {
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

  const PrintObjTransaction({
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
}
