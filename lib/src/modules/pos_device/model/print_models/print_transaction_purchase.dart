class PrintTransactionPurchase {
  final String filePath;
  final String appVersionText;
  final String merchantId;
  final String merchantName;
  //
  final String terminalId;
  final String date;
  final String stan;
  final String rrn;
  final String aid;
  final String amount;
  final String status;
  final String narration;

  const PrintTransactionPurchase({
    required this.filePath,
    required this.appVersionText,
    required this.merchantId,
    required this.merchantName,
    required this.terminalId,
    required this.date,
    required this.stan,
    required this.rrn,
    required this.aid,
    required this.amount,
    required this.status,
    required this.narration,
  });

  @override
  String toString() {
    return '''PrintTransactionPurchase(
      filePath: $filePath,
      appVersionText: $appVersionText,
      merchantId: $merchantId,
      merchantName: $merchantName,
      terminalId: $terminalId,
      date: $date,
      stan: $stan,
      rrn: $rrn,
      aid: $aid,
      amount: $amount,
      status: $status,
      narration: $narration,
    )''';
  }
}
