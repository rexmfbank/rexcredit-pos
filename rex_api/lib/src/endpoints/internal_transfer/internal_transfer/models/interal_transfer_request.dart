import 'package:equatable/equatable.dart';

class InternalTransferRequest extends Equatable {
  final String? externalRefNo;
  final String? terminalId;
  final String deviceId;
  final String sourceAccount;
  final String tranCode;
  final String senderName;
  final String beneficiaryAccount;
  final String beneficiaryName;
  final String beneficiaryMobile;
  final String beneficiaryBankCode;
  final String beneficiaryAccountType;
  final String entityCode;
  final String geolocation;
  final num amount;
  final String? charge;
  final String currencyCode;
  final String narration;
  final String paymentMethod;
  final UfdData? ufdData;
  final String channelType;
  final String network;
  final String username;
  final bool saveBeneficiary;

  const InternalTransferRequest({
    this.externalRefNo,
    this.terminalId,
    required this.deviceId,
    required this.sourceAccount,
    required this.tranCode,
    required this.senderName,
    required this.beneficiaryAccount,
    required this.beneficiaryName,
    required this.beneficiaryMobile,
    required this.beneficiaryBankCode,
    required this.beneficiaryAccountType,
    required this.entityCode,
    required this.geolocation,
    required this.amount,
    this.charge,
    required this.currencyCode,
    required this.narration,
    required this.paymentMethod,
    this.ufdData,
    required this.channelType,
    required this.network,
    required this.username,
    required this.saveBeneficiary,
  });

  Map<String, dynamic> toJson() => {
        "externalRefNo": externalRefNo,
        "terminalId": terminalId,
        "deviceId": deviceId,
        "sourceAccount": sourceAccount,
        "tranCode": tranCode,
        "senderName": senderName,
        "beneficiaryAccount": beneficiaryAccount,
        "beneficiaryName": beneficiaryName,
        "beneficiaryMobile": beneficiaryMobile,
        "beneficiaryBankCode": beneficiaryBankCode,
        "beneficiaryAccountType": beneficiaryAccountType,
        "entityCode": entityCode,
        "geolocation": geolocation,
        "amount": amount,
        "charge": charge,
        "currencyCode": currencyCode,
        "narration": narration,
        "paymentMethod": paymentMethod,
        "channelType": channelType,
        "ufdData": null,
        "network": network,
        "username": username,
        "saveBeneficiary": saveBeneficiary,
      };

  @override
  List<Object?> get props => [
        externalRefNo,
        terminalId,
        deviceId,
        sourceAccount,
        tranCode,
        senderName,
        beneficiaryAccount,
        beneficiaryName,
        beneficiaryMobile,
        beneficiaryBankCode,
        beneficiaryAccountType,
        entityCode,
        geolocation,
        amount,
        charge,
        currencyCode,
        narration,
        paymentMethod,
        ufdData,
        channelType,
        network,
        username,
        saveBeneficiary,
      ];
}

class UfdData {
  final String? fieldName;
  final String? fieldCode;
  final String? fieldValue;

  const UfdData({this.fieldName, this.fieldCode, this.fieldValue});

  UfdData.empty()
      : fieldName = '',
        fieldCode = '',
        fieldValue = '';

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "fieldCode": fieldCode,
        "fieldValue": fieldValue,
      };
}
