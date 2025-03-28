enum TransactionCodes {
  internalTransfer('ITR'),
  intraBankTransfer('ITRA'),
  interTransfer('IBFT'),
  topUp('TOPUP'),
  data('DATS'),
  cable('CATV'),
  power('ELCE'),
  others('BILL'),
  fundSavingsWithCard('SACD'),
  fundSavingsWithAccount('SACA'),
  withdrawal('WA'),
  loanDisbursement('LDA'),
  loanRepayment('LNRP'),
  topUpAccountWithCard('TUA'),
  transaction('');

  const TransactionCodes(this.jsonString);
  final String jsonString;
}

extension TransactionCodesFromString on String? {
  TransactionCodes? get transactionCodes {
    return TransactionCodes.values.firstWhere(
      (element) => element.jsonString == this,
      orElse: () => TransactionCodes.transaction,
    );
  }
}
