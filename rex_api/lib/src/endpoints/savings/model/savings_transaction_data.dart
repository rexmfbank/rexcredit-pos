import 'package:equatable/equatable.dart';

class SavingsTransactionData extends Equatable {
  final int? id;
  final Object? branchCode;
  final String? entityCode;
  final Object? merchantCode;
  final int? tranDate;
  final Object? valueDate;
  final String? tranCode;
  final Object? channelType;
  final Object? tranType;
  final String? tranRefNo;
  final Object? tranDesc;
  final num? amount;
  final String? crDr;
  final Object? ccy;
  final Object? accountNo;
  final Object? debitAccount;
  final Object? creditAccount;
  final Object? match;
  final Object? reconDate;
  final Object? reconBy;
  final Object? notes;
  final int? createdDate;
  final String? createdBy;
  final String? journalRefNo;
  final Object? merchantId;
  final Object? geoLocation;
  final Object? deviceId;
  final Object? location;
  final Object? mccCode;
  final Object? productCode;
  final Object? paymentChannel;
  final String? paymentRspCode;
  final Object? paymentRspMsg;
  final Object? paymentRefNo;
  final Object? paymentAuthCode;
  final Object? cbaRspCode;
  final String? cbaRspMsg;
  final Object? cbaRspRef;
  final num? commission;
  final Object? beneficiaryFinCode;
  final Object? beneficiaryAccType;
  final Object? beneficiaryName;
  final Object? beneficiaryAccount;
  final Object? beneficiaryMobile;
  final Object? customerCommission;
  final Object? senderMobile;
  final Object? senderName;
  final Object? platformCommission;
  final Object? serviceFee;
  final String? tranUniqRefNo;
  final Object? sessionId;
  final String? customerId;
  final Object? tranCategorize;
  final Object? retryNo;
  final Object? status;
  final Object? verifyStatus;
  final Object? verifiedDate;
  final Object? rrn;
  final Object? stan;
  final Object? verifiedBy;
  final num? aggregatorCommission;
  final Object? networkCommission;
  final Object? provider;
  final String? cardNo;
  final Object? feePosted;
  final Object? feePostingRef;
  final Object? settlementMsg;
  final Object? smsSent;
  final Object? accountId;
  final num? agentCommission;
  final String? billRspCode;
  final Object? billRspMsg;
  final Object? billRspRef;
  final String? narration;
  final Object? internalRefId;
  final Object? categorized;
  final Object? journalId;
  final Object? personalTranType;

  const SavingsTransactionData({
    required this.id,
    required this.branchCode,
    required this.entityCode,
    required this.merchantCode,
    required this.tranDate,
    required this.valueDate,
    required this.tranCode,
    required this.channelType,
    required this.tranType,
    required this.tranRefNo,
    required this.tranDesc,
    required this.amount,
    required this.crDr,
    required this.ccy,
    required this.accountNo,
    required this.debitAccount,
    required this.creditAccount,
    required this.match,
    required this.reconDate,
    required this.reconBy,
    required this.notes,
    required this.createdDate,
    required this.createdBy,
    required this.journalRefNo,
    required this.merchantId,
    required this.geoLocation,
    required this.deviceId,
    required this.location,
    required this.mccCode,
    required this.productCode,
    required this.paymentChannel,
    required this.paymentRspCode,
    required this.paymentRspMsg,
    required this.paymentRefNo,
    required this.paymentAuthCode,
    required this.cbaRspCode,
    required this.cbaRspMsg,
    required this.cbaRspRef,
    required this.commission,
    required this.beneficiaryFinCode,
    required this.beneficiaryAccType,
    required this.beneficiaryName,
    required this.beneficiaryAccount,
    required this.beneficiaryMobile,
    required this.customerCommission,
    required this.senderMobile,
    required this.senderName,
    required this.platformCommission,
    required this.serviceFee,
    required this.tranUniqRefNo,
    required this.sessionId,
    required this.customerId,
    required this.tranCategorize,
    required this.retryNo,
    required this.status,
    required this.verifyStatus,
    required this.verifiedDate,
    required this.rrn,
    required this.stan,
    required this.verifiedBy,
    required this.aggregatorCommission,
    required this.networkCommission,
    required this.provider,
    required this.cardNo,
    required this.feePosted,
    required this.feePostingRef,
    required this.settlementMsg,
    required this.smsSent,
    required this.accountId,
    required this.agentCommission,
    required this.billRspCode,
    required this.billRspMsg,
    required this.billRspRef,
    required this.narration,
    required this.internalRefId,
    required this.categorized,
    required this.journalId,
    required this.personalTranType,
  });

  const SavingsTransactionData.empty()
      : id = null,
        branchCode = null,
        entityCode = null,
        merchantCode = null,
        tranDate = null,
        valueDate = null,
        tranCode = null,
        channelType = null,
        tranType = null,
        tranRefNo = null,
        tranDesc = null,
        amount = null,
        crDr = null,
        ccy = null,
        accountNo = null,
        debitAccount = null,
        creditAccount = null,
        match = null,
        reconDate = null,
        reconBy = null,
        notes = null,
        createdDate = null,
        createdBy = null,
        journalRefNo = null,
        merchantId = null,
        geoLocation = null,
        deviceId = null,
        location = null,
        mccCode = null,
        productCode = null,
        paymentChannel = null,
        paymentRspCode = null,
        paymentRspMsg = null,
        paymentRefNo = null,
        paymentAuthCode = null,
        cbaRspCode = null,
        cbaRspMsg = null,
        cbaRspRef = null,
        commission = null,
        beneficiaryFinCode = null,
        beneficiaryAccType = null,
        beneficiaryName = null,
        beneficiaryAccount = null,
        beneficiaryMobile = null,
        customerCommission = null,
        senderMobile = null,
        senderName = null,
        platformCommission = null,
        serviceFee = null,
        tranUniqRefNo = null,
        sessionId = null,
        customerId = null,
        tranCategorize = null,
        retryNo = null,
        status = null,
        verifyStatus = null,
        verifiedDate = null,
        rrn = null,
        stan = null,
        verifiedBy = null,
        aggregatorCommission = 0,
        networkCommission = null,
        provider = null,
        cardNo = null,
        feePosted = null,
        feePostingRef = null,
        settlementMsg = null,
        smsSent = null,
        accountId = null,
        agentCommission = 0,
        billRspCode = null,
        billRspMsg = null,
        billRspRef = null,
        narration = null,
        internalRefId = null,
        categorized = null,
        journalId = null,
        personalTranType = null;

  factory SavingsTransactionData.fromJson(Map<String, dynamic> json) =>
      SavingsTransactionData(
        id: json["id"],
        branchCode: json["branchCode"],
        entityCode: json["entityCode"],
        merchantCode: json["merchantCode"],
        tranDate: json["tranDate"],
        valueDate: json["valueDate"],
        tranCode: json["tranCode"],
        channelType: json["channelType"],
        tranType: json["tranType"],
        tranRefNo: json["tranRefNo"],
        tranDesc: json["tranDesc"],
        amount: json["amount"],
        crDr: json["crDr"],
        ccy: json["ccy"],
        accountNo: json["accountNo"],
        debitAccount: json["debitAccount"],
        creditAccount: json["creditAccount"],
        match: json["match"],
        reconDate: json["reconDate"],
        reconBy: json["reconBy"],
        notes: json["notes"],
        createdDate: json["createdDate"],
        createdBy: json["createdBy"],
        journalRefNo: json["journalRefNo"],
        merchantId: json["merchantId"],
        geoLocation: json["geoLocation"],
        deviceId: json["deviceId"],
        location: json["location"],
        mccCode: json["mccCode"],
        productCode: json["productCode"],
        paymentChannel: json["paymentChannel"],
        paymentRspCode: json["paymentRspCode"],
        paymentRspMsg: json["paymentRspMsg"],
        paymentRefNo: json["paymentRefNo"],
        paymentAuthCode: json["paymentAuthCode"],
        cbaRspCode: json["cbaRspCode"],
        cbaRspMsg: json["cbaRspMsg"],
        cbaRspRef: json["cbaRspRef"],
        commission: json["commission"],
        beneficiaryFinCode: json["beneficiaryFinCode"],
        beneficiaryAccType: json["beneficiaryAccType"],
        beneficiaryName: json["beneficiaryName"],
        beneficiaryAccount: json["beneficiaryAccount"],
        beneficiaryMobile: json["beneficiaryMobile"],
        customerCommission: json["customerCommission"],
        senderMobile: json["senderMobile"],
        senderName: json["senderName"],
        platformCommission: json["platformCommission"],
        serviceFee: json["serviceFee"],
        tranUniqRefNo: json["tranUniqRefNo"],
        sessionId: json["sessionId"],
        customerId: json["customerId"],
        tranCategorize: json["tranCategorize"],
        retryNo: json["retryNo"],
        status: json["status"],
        verifyStatus: json["verifyStatus"],
        verifiedDate: json["verifiedDate"],
        rrn: json["rrn"],
        stan: json["stan"],
        verifiedBy: json["verifiedBy"],
        aggregatorCommission: json["aggregatorCommission"],
        networkCommission: json["networkCommission"],
        provider: json["provider"],
        cardNo: json["cardNo"],
        feePosted: json["feePosted"],
        feePostingRef: json["feePostingRef"],
        settlementMsg: json["settlementMsg"],
        smsSent: json["smsSent"],
        accountId: json["accountId"],
        agentCommission: json["agentCommission"],
        billRspCode: json["billRspCode"],
        billRspMsg: json["billRspMsg"],
        billRspRef: json["billRspRef"],
        narration: json["narration"],
        internalRefId: json["internalRefId"],
        categorized: json["categorized"],
        journalId: json["journalId"],
        personalTranType: json["personalTranType"],
      );

  @override
  String toString() => {
        "CLASS": "SavingsTransactionData",
        "narration": narration,
        "createdBy": createdBy,
        "amount": amount,
      }.toString();

  @override
  List<Object?> get props => [narration, createdBy, amount];
}
