class BaseappTransactionEntity {
  final int? id;
  final String aid;
  final String amount;
  final String cashBackAmount;
  final String appLabel;
  final String authcode;
  final String cardExpireDate;
  final String cardHolderName;
  final String dateAndTime;
  final String maskedPan;
  final String message;
  final String nuban;
  final String pinType;
  final String rrn;
  final String stan;
  final String statuscode;
  final String terminalId;
  final String transactionType;
  final String merchantName;
  final String merchantId;
  final String merchantAddress;
  final String merchantCategoryCode;
  final String bankName;
  final String bankLogo;
  final String ptsp;
  final String ptspContact;
  final String footerMessage;
  final String deviceSerialNumber;
  final String baseAppVersion;
  final String currency;

  BaseappTransactionEntity({
    this.id,
    required this.aid,
    required this.amount,
    required this.cashBackAmount,
    required this.appLabel,
    required this.authcode,
    required this.cardExpireDate,
    required this.cardHolderName,
    required this.dateAndTime,
    required this.maskedPan,
    required this.message,
    required this.nuban,
    required this.pinType,
    required this.rrn,
    required this.stan,
    required this.statuscode,
    required this.terminalId,
    required this.transactionType,
    required this.merchantName,
    required this.merchantId,
    required this.merchantAddress,
    required this.merchantCategoryCode,
    required this.bankName,
    required this.bankLogo,
    required this.ptsp,
    required this.ptspContact,
    required this.footerMessage,
    required this.deviceSerialNumber,
    required this.baseAppVersion,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aid': aid,
      'amount': amount,
      'cashBackAmount': cashBackAmount,
      'appLabel': appLabel,
      'authcode': authcode,
      'cardExpireDate': cardExpireDate,
      'cardHolderName': cardHolderName,
      'dateAndTime': dateAndTime,
      'maskedPan': maskedPan,
      'message': message,
      'nuban': nuban,
      'pinType': pinType,
      'rrn': rrn,
      'stan': stan,
      'statuscode': statuscode,
      'terminalId': terminalId,
      'transactionType': transactionType,
      'merchantName': merchantName,
      'merchantId': merchantId,
      'merchantAddress': merchantAddress,
      'merchantCategoryCode': merchantCategoryCode,
      'bankName': bankName,
      'bankLogo': bankLogo,
      'ptsp': ptsp,
      'ptspContact': ptspContact,
      'footerMessage': footerMessage,
      'deviceSerialNumber': deviceSerialNumber,
      'baseAppVersion': baseAppVersion,
      'currency': currency,
    };
  }

  factory BaseappTransactionEntity.fromMap(Map<String, dynamic> map) {
    return BaseappTransactionEntity(
      id: map['id'],
      aid: map['aid'],
      amount: map['amount'],
      cashBackAmount: map['cashBackAmount'],
      appLabel: map['appLabel'],
      authcode: map['authcode'],
      cardExpireDate: map['cardExpireDate'],
      cardHolderName: map['cardHolderName'],
      dateAndTime: map['dateAndTime'],
      maskedPan: map['maskedPan'],
      message: map['message'],
      nuban: map['nuban'],
      pinType: map['pinType'],
      rrn: map['rrn'],
      stan: map['stan'],
      statuscode: map['statuscode'],
      terminalId: map['terminalId'],
      transactionType: map['transactionType'],
      merchantName: map['merchantName'],
      merchantId: map['merchantId'],
      merchantAddress: map['merchantAddress'],
      merchantCategoryCode: map['merchantCategoryCode'],
      bankName: map['bankName'],
      bankLogo: map['bankLogo'],
      ptsp: map['ptsp'],
      ptspContact: map['ptspContact'],
      footerMessage: map['footerMessage'],
      deviceSerialNumber: map['deviceSerialNumber'],
      baseAppVersion: map['baseAppVersion'],
      currency: map['currency'],
    );
  }
}
