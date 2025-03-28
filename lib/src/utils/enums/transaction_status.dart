enum TransactionStatus {
  pending('PENDING', 'Pending'),
  success('SUCCESSFUL', 'Successful'),
  failed('FAILED', 'Failed'),
  paid('PAID', 'Paid'),
  notPaid('NOT_PAID', 'Not_Paid'),
  none('NONE', 'None');

  const TransactionStatus(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension TransactionStatusFromString on String? {
  TransactionStatus? get transactionStatus {
    return TransactionStatus.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => TransactionStatus.none,
    );
  }

  TransactionStatus? get jsonTransactionStatus {
    return TransactionStatus.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => TransactionStatus.none,
    );
  }
}
