class PrintCardPurchase {
  final String filePath;
  final String copyType;
  final String appVersionText;
  //
  final String merchantName;
  final String merchantId;
  final String terminalId;
  final String datetime;
  final String aid;
  final String maskedPan;
  final String stan;
  final String rrn;
  final String amount;
  final String appLabel;
  final String message;

  PrintCardPurchase({
    required this.filePath,
    required this.copyType,
    required this.appVersionText,
    required this.merchantName,
    required this.merchantId,
    required this.terminalId,
    required this.datetime,
    required this.aid,
    required this.maskedPan,
    required this.stan,
    required this.rrn,
    required this.amount,
    required this.appLabel,
    required this.message,
  });

  @override
  String toString() {
    return '''PrintCardPurchase(
      filepath: $filePath,
      copyType: $copyType,
      appVersionText: $appVersionText,
      merchantName: $merchantName,
      merchantId: $merchantId,
      terminalId: $terminalId,
      datetime: $datetime,
      aid: $aid,
      maskedPan: $maskedPan,
      stan: $stan,
      rrn: $rrn,
      amount: $amount,
      appLabel: $appLabel,
      message: $message,
    )''';
  }
}
