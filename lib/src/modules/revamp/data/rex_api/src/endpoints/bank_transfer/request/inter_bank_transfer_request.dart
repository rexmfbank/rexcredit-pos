import '../../../utils/enums/enums.dart';

class InterBankTransferRequest {
  final String externalRefNo;
  final String terminalId;
  final String deviceId;
  final String pin;
  final String sourceAccount;
  final String? tranCode;
  final String senderName;
  final String beneficiaryAccount;
  final String beneficiaryName;
  final String beneficiaryMobile;
  final String beneficiaryBankCode;
  final String beneficiaryAccountType;
  final String entityCode;
  final String geolocation;
  final double amount;
  final double? charge;
  final String? currencyCode;
  final String narration;
  final String? paymentMethod;
  final String? channelType;
  final String? network;
  final String username;
  final bool saveBeneficiary;

  InterBankTransferRequest({
    required this.externalRefNo,
    required this.terminalId,
    required this.deviceId,
    required this.pin,
    required this.sourceAccount,
    required this.senderName,
    required this.beneficiaryAccount,
    required this.beneficiaryName,
    required this.beneficiaryMobile,
    required this.beneficiaryBankCode,
    required this.beneficiaryAccountType,
    required this.entityCode,
    required this.geolocation,
    required this.amount,
    this.tranCode,
    this.charge,
    this.currencyCode,
    required this.narration,
    this.paymentMethod,
    this.channelType,
    this.network,
    required this.username,
    required this.saveBeneficiary,
  });

  Map<String, dynamic> toJson() => {
        "externalRefNo": externalRefNo,
        "terminalId": terminalId,
        "deviceId": deviceId,
        "sourceAccount": sourceAccount,
        "tranCode": 'IBTF',
        "senderName": senderName,
        "beneficiaryAccount": beneficiaryAccount,
        "beneficiaryName": beneficiaryName,
        "beneficiaryMobile": beneficiaryMobile,
        "beneficiaryBankCode": beneficiaryBankCode,
        "beneficiaryAccountType": beneficiaryAccountType,
        "entityCode": entityCode,
        "geolocation": geolocation,
        "amount": amount,
        "charge": 0,
        "currencyCode": 'NGN',
        "narration": narration,
        "paymentMethod": PaymentMethod.cash.jsonString,
        "udfData": {
          "fieldName": "string",
          "fieldCode": "string",
          "fieldValue": "string"
        },
        "channelType": ChannelType.mobile.jsonString,
        "network": network ?? '',
        "username": username,
        "saveBeneficiary": saveBeneficiary,
      };
}

class UdfData {
  final String fieldName;
  final String fieldCode;
  final String fieldValue;

  UdfData({
    required this.fieldName,
    required this.fieldCode,
    required this.fieldValue,
  });

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "fieldCode": fieldCode,
        "fieldValue": fieldValue,
      };
}
