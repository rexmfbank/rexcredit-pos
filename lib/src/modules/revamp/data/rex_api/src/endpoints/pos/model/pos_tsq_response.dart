import 'package:equatable/equatable.dart';

class PosTsqResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final PosTsqData data;

  const PosTsqResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  const PosTsqResponse.empty()
    : responseCode = '',
      responseMessage = '',
      data = const PosTsqData.empty();

  factory PosTsqResponse.fromJson(Map<String, dynamic> json) => PosTsqResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: PosTsqData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };

  @override
  String toString() => "PosTsqResponse: ${toJson()}";

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}

class PosTsqData extends Equatable {
  final bool success;
  final String message;
  final TsqTransactionData? tsqTransData;

  const PosTsqData({
    required this.success,
    required this.message,
    required this.tsqTransData,
  });

  const PosTsqData.empty()
    : success = false,
      message = "",
      tsqTransData = const TsqTransactionData.empty();

  factory PosTsqData.fromJson(Map<String, dynamic> json) => PosTsqData(
    success: json["success"],
    message: json["message"],
    tsqTransData: TsqTransactionData.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": tsqTransData?.toJson(),
  };

  @override
  String toString() {
    return 'PosTsqData{success: $success, message: $message, data: $tsqTransData}';
  }

  @override
  List<Object?> get props => [success, message, tsqTransData];
}

class TsqTransactionData extends Equatable {
  final String? id;
  final String? transRef;
  final String? currency;
  final String? mti;
  final double? amount;
  final String? transDate;
  final String? processingCode;
  final String? stan;
  final String? pan;
  final String? rrn;
  final String? authCode;
  final String? dateExp;
  final String? responseCode;
  final String? transactionType;
  final String? status;
  final String? terminalId;
  final String? merchantId;
  final String? merchantName;
  final String? cardHolder;
  final String? hostIp;
  final String? hostPort;
  final String? serialNumber;
  final String? extraInfo;
  final String? appVersion;
  final String? transactionRemarks;
  final String? processingTime;

  const TsqTransactionData({
    this.id,
    this.transRef,
    this.currency,
    this.mti,
    this.amount,
    this.transDate,
    this.processingCode,
    this.stan,
    this.pan,
    this.rrn,
    this.authCode,
    this.dateExp,
    this.responseCode,
    this.transactionType,
    this.status,
    this.terminalId,
    this.merchantId,
    this.merchantName,
    this.cardHolder,
    this.hostIp,
    this.hostPort,
    this.serialNumber,
    this.extraInfo,
    this.appVersion,
    this.transactionRemarks,
    this.processingTime,
  });

  const TsqTransactionData.empty()
    : id = null,
      transRef = null,
      currency = null,
      mti = null,
      amount = null,
      transDate = null,
      processingCode = null,
      stan = null,
      pan = null,
      rrn = null,
      authCode = null,
      dateExp = null,
      responseCode = null,
      transactionType = null,
      status = null,
      terminalId = null,
      merchantId = null,
      merchantName = null,
      cardHolder = null,
      hostIp = null,
      hostPort = null,
      serialNumber = null,
      extraInfo = null,
      appVersion = null,
      transactionRemarks = null,
      processingTime = null;

  factory TsqTransactionData.fromJson(Map<String, dynamic> json) =>
      TsqTransactionData(
        id: json["id"],
        transRef: json["transRef"],
        currency: json["currency"],
        mti: json["mti"],
        amount: (json["amount"] as num?)?.toDouble(),
        transDate: json["transDate"],
        processingCode: json["processingCode"],
        stan: json["stan"],
        pan: json["pan"],
        rrn: json["rrn"],
        authCode: json["authCode"],
        dateExp: json["dateExp"],
        responseCode: json["responseCode"],
        transactionType: json["transactionType"],
        status: json["status"],
        terminalId: json["terminalId"],
        merchantId: json["merchantId"],
        merchantName: json["merchantName"],
        cardHolder: json["cardHolder"],
        hostIp: json["hostIp"],
        hostPort: json["hostPort"],
        serialNumber: json["serialNumber"],
        extraInfo: json["extraInfo"],
        appVersion: json["appVersion"],
        transactionRemarks: json["transaction_remarks"],
        processingTime: json["processing_time"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transRef": transRef,
    "currency": currency,
    "mti": mti,
    "amount": amount,
    "transDate": transDate,
    "processingCode": processingCode,
    "stan": stan,
    "pan": pan,
    "rrn": rrn,
    "authCode": authCode,
    "dateExp": dateExp,
    "responseCode": responseCode,
    "transactionType": transactionType,
    "status": status,
    "terminalId": terminalId,
    "merchantId": merchantId,
    "merchantName": merchantName,
    "cardHolder": cardHolder,
    "hostIp": hostIp,
    "hostPort": hostPort,
    "serialNumber": serialNumber,
    "extraInfo": extraInfo,
    "appVersion": appVersion,
    "transaction_remarks": transactionRemarks,
    "processing_time": processingTime,
  };

  @override
  String toString() => "TsqTransactionsData: ${toJson()}";

  @override
  List<Object?> get props => [
    id,
    transRef,
    currency,
    mti,
    amount,
    transDate,
    processingCode,
    stan,
    pan,
    rrn,
    authCode,
    dateExp,
    responseCode,
    transactionType,
    status,
    terminalId,
    merchantId,
    merchantName,
    cardHolder,
    hostIp,
    hostPort,
    serialNumber,
    extraInfo,
    appVersion,
    transactionRemarks,
    processingTime,
  ];
}
