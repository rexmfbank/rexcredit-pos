class CardPaymentInformation {
  final String? amount;
  final String? appLabel;
  final String? authCode;
  final String? cardExpireDate;
  final String? cardHolderName;
  final String? maskedPan;
  final String? message;
  final String? nuban;
  final String? rrn;
  final String? stan;
  final String? statusCode;
  final String? terminalId;
  final String? dateTime;

  const CardPaymentInformation({
    this.amount,
    this.appLabel,
    this.authCode,
    this.cardExpireDate,
    this.cardHolderName,
    this.maskedPan,
    this.message,
    this.nuban,
    this.rrn,
    this.stan,
    this.statusCode,
    this.terminalId,
    this.dateTime,
  });

  bool paymentSuccess() => statusCode?.endsWith('00') == true;

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'appLabel': appLabel,
      'authCode': authCode,
      'cardExpireDate': cardExpireDate,
      'cardHolderName': cardHolderName,
      'maskedPan': maskedPan,
      'message': message,
      'nuban': nuban,
      'rrn': rrn,
      'stan': stan,
      'statusCode': statusCode,
      'terminalId': terminalId,
      'dateTime': dateTime,
    };
  }

  factory CardPaymentInformation.fromMap(Map<String, dynamic> map) {
    return CardPaymentInformation(
      amount: map['amount'],
      appLabel: map['appLabel'],
      authCode: map['authCode'],
      cardExpireDate: map['cardExpireDate'],
      cardHolderName: map['cardHolderName'],
      maskedPan: map['maskedPan'],
      message: map['message'],
      nuban: map['nuban'],
      rrn: map['rrn'],
      stan: map['stan'],
      statusCode: map['statusCode'],
      terminalId: map['terminalId'],
      dateTime: map['dateTime'],
    );
  }

  CardPaymentInformation copyWith({
    String? amount,
    String? appLabel,
    String? authCode,
    String? cardExpireDate,
    String? cardHolderName,
    String? maskedPan,
    String? message,
    String? nuban,
    String? rrn,
    String? stan,
    String? statusCode,
    String? terminalId,
    String? dateTime,
  }) {
    return CardPaymentInformation(
      amount: amount ?? this.amount,
      appLabel: appLabel ?? this.appLabel,
      authCode: authCode ?? this.authCode,
      cardExpireDate: cardExpireDate ?? this.cardExpireDate,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      maskedPan: maskedPan ?? this.maskedPan,
      message: message ?? this.message,
      nuban: nuban ?? this.nuban,
      rrn: rrn ?? this.rrn,
      stan: stan ?? this.stan,
      statusCode: statusCode ?? this.statusCode,
      terminalId: terminalId ?? this.terminalId,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
