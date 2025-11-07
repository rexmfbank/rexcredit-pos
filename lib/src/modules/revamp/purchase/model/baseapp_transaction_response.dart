import 'dart:convert';
import 'package:equatable/equatable.dart';

BaseAppTransResponse intentTransactionResponseFromJson(String str) =>
    BaseAppTransResponse.fromJson(json.decode(str));

String intentTransactionResponseToJson(BaseAppTransResponse data) =>
    json.encode(data.toJson());

class BaseAppTransResponse extends Equatable {
  final String? aid;
  final String? amount;
  final String? cashBackAmount;
  final String? appLabel;
  final String? authcode;
  final String? cardExpireDate;
  final String? cardHolderName;
  final String? datetime;
  final String? maskedPan;
  final String? message;
  final String? nuban;
  final String? pinType;
  final String? rrn;
  final String? stan;
  final String? statuscode;
  final String? terminalId;
  final String? transactionType;
  final String? merchantName;
  final String? merchantId;
  final String? merchantAddress;
  final String? merchantCategoryCode;
  final String? bankName;
  final String? bankLogo;
  final String? ptsp;
  final String? ptspContact;
  final String? footerMessage;
  final String? deviceSerialNumber;
  final String? baseAppVersion;
  final String? currency;

  const BaseAppTransResponse({
    this.aid,
    this.amount,
    this.cashBackAmount,
    this.appLabel,
    this.authcode,
    this.cardExpireDate,
    this.cardHolderName,
    this.datetime,
    this.maskedPan,
    this.message,
    this.nuban,
    this.pinType,
    this.rrn,
    this.stan,
    this.statuscode,
    this.terminalId,
    this.transactionType,
    this.merchantName,
    this.merchantId,
    this.merchantAddress,
    this.merchantCategoryCode,
    this.bankName,
    this.bankLogo,
    this.ptsp,
    this.ptspContact,
    this.footerMessage,
    this.deviceSerialNumber,
    this.baseAppVersion,
    this.currency,
  });

  const BaseAppTransResponse.empty()
    : aid = null,
      amount = null,
      cashBackAmount = null,
      appLabel = null,
      authcode = null,
      cardExpireDate = null,
      cardHolderName = null,
      datetime = null,
      maskedPan = null,
      message = null,
      nuban = null,
      pinType = null,
      rrn = null,
      stan = null,
      statuscode = null,
      terminalId = null,
      transactionType = null,
      merchantName = null,
      merchantId = null,
      merchantAddress = null,
      merchantCategoryCode = null,
      bankName = null,
      bankLogo = null,
      ptsp = null,
      ptspContact = null,
      footerMessage = null,
      deviceSerialNumber = null,
      baseAppVersion = null,
      currency = null;

  factory BaseAppTransResponse.fromJson(Map<String, dynamic> json) =>
      BaseAppTransResponse(
        aid: json["aid"],
        amount: json["amount"],
        cashBackAmount: json["cashBackAmount"],
        appLabel: json["appLabel"],
        authcode: json["authcode"],
        cardExpireDate: json["cardExpireDate"],
        cardHolderName: json["cardHolderName"],
        datetime: json["datetime"],
        maskedPan: json["maskedPan"],
        message: json["message"],
        nuban: json["nuban"],
        pinType: json["pinType"],
        rrn: json["rrn"],
        stan: json["stan"],
        statuscode: json["statuscode"],
        terminalId: json["terminalID"],
        transactionType: json["transactionType"],
        merchantName: json["merchantName"],
        merchantId: json["merchantId"],
        merchantAddress: json["merchantAddress"],
        merchantCategoryCode: json["merchantCategoryCode"],
        bankName: json["bankName"],
        bankLogo: json["bankLogo"],
        ptsp: json["ptsp"],
        ptspContact: json["ptspContact"],
        footerMessage: json["footerMessage"],
        deviceSerialNumber: json["deviceSerialNumber"],
        baseAppVersion: json["baseAppVersion"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
    "aid": aid,
    "amount": amount,
    "cashBackAmount": cashBackAmount,
    "appLabel": appLabel,
    "authcode": authcode,
    "cardExpireDate": cardExpireDate,
    "cardHolderName": cardHolderName,
    "datetime": datetime,
    "maskedPan": maskedPan,
    "message": message,
    "nuban": nuban,
    "pinType": pinType,
    "rrn": rrn,
    "stan": stan,
    "statuscode": statuscode,
    "terminalID": terminalId,
    "transactionType": transactionType,
    "merchantName": merchantName,
    "merchantId": merchantId,
    "merchantAddress": merchantAddress,
    "merchantCategoryCode": merchantCategoryCode,
    "bankName": bankName,
    "bankLogo": bankLogo,
    "ptsp": ptsp,
    "ptspContact": ptspContact,
    "footerMessage": footerMessage,
    "deviceSerialNumber": deviceSerialNumber,
    "baseAppVersion": baseAppVersion,
    "currency": currency,
  };

  @override
  String toString() => "IntentTransactionResponse ${toJson()}";

  @override
  List<Object?> get props => [];
}
