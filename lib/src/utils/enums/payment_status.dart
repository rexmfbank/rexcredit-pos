enum PaymentStatus {
  pending('PENDING', 'Pending'),
  success('SUCCESS', 'Success'),
  failed('FAILED', 'Failed'),
  paid('PAID', 'Paid'),
  notPaid('NOT_PAID', 'Not_Paid'),
  none('NONE', 'None');

  const PaymentStatus(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension PaymentStatusFromString on String? {
  PaymentStatus? get paymentStatus {
    return PaymentStatus.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => PaymentStatus.none,
    );
  }

  PaymentStatus? get jsonPaymentStatus {
    return PaymentStatus.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => PaymentStatus.none,
    );
  }
}
