class PrintTransactionTransfer {
  final String filePath;
  final String appVersionText;
  final String merchantId;
  final String merchantName;
  final String terminalId;
  //
  final String tranDate;
  final String amount;
  final String tranUniqRefNo;
  final String status;
  final String beneficiaryName;
  final String beneficiaryAccountNo;
  final String beneficiaryBank;
  final String senderName;
  final String senderAccountNumber;

  const PrintTransactionTransfer({
    required this.filePath,
    required this.appVersionText,
    required this.merchantId,
    required this.merchantName,
    required this.terminalId,
    required this.tranDate,
    required this.amount,
    required this.tranUniqRefNo,
    required this.status,
    required this.beneficiaryName,
    required this.beneficiaryAccountNo,
    required this.beneficiaryBank,
    required this.senderName,
    required this.senderAccountNumber,
  });
}
