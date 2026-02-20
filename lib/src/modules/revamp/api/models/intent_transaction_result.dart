import 'package:equatable/equatable.dart';

class IntentTransactionResult extends Equatable {
  final String aid;
  final String amount;
  final String appLabel;
  final String authcode;
  final String bankLogo;
  final String bankName;
  final String baseAppVersion;
  final String cardExpireDate;
  final String cardHolderName;
  final String currency;
  final String datetime;
  final String footerMessage;
  final String maskedPan;
  final String merchantAddress;
  final String merchantCategoryCode;
  final String merchantId;
  final String merchantName;
  final String message;
  final String nuban;
  final String pinType;
  final String posEntryMode;
  final String ptsp;
  final String rrn;
  final String stan;
  final String statuscode;
  final String terminalID;
  final String transactionType;

  const IntentTransactionResult({
    required this.aid,
    required this.amount,
    required this.appLabel,
    required this.authcode,
    required this.bankLogo,
    required this.bankName,
    required this.baseAppVersion,
    required this.cardExpireDate,
    required this.cardHolderName,
    required this.currency,
    required this.datetime,
    required this.footerMessage,
    required this.maskedPan,
    required this.merchantAddress,
    required this.merchantCategoryCode,
    required this.merchantId,
    required this.merchantName,
    required this.message,
    required this.nuban,
    required this.pinType,
    required this.posEntryMode,
    required this.ptsp,
    required this.rrn,
    required this.stan,
    required this.statuscode,
    required this.terminalID,
    required this.transactionType,
  });

  Map<String, dynamic> toJson() {
    return {
      'aid': aid,
      'amount': amount,
      'appLabel': appLabel,
      'authcode': authcode,
      'bankLogo': bankLogo,
      'bankName': bankName,
      'baseAppVersion': baseAppVersion,
      'cardExpireDate': cardExpireDate,
      'cardHolderName': cardHolderName,
      'currency': currency,
      'datetime': datetime,
      'footerMessage': footerMessage,
      'maskedPan': maskedPan,
      'merchantAddress': merchantAddress,
      'merchantCategoryCode': merchantCategoryCode,
      'merchantId': merchantId,
      'merchantName': merchantName,
      'message': message,
      'nuban': nuban,
      'pinType': pinType,
      'posEntryMode': posEntryMode,
      'ptsp': ptsp,
      'rrn': rrn,
      'stan': stan,
      'statuscode': statuscode,
      'terminalID': terminalID,
      'transactionType': transactionType,
    };
  }

  @override
  List<Object?> get props => [];
}
