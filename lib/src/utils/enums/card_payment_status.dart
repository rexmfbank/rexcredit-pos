enum CardPaymentStatus {
  approved('APPROVED'),
  declined('DECLINED'),
  cancel('CANCEL'),
  timeout('TIMEOUT'),
  failed('FAILED'),
  none('NONE');

  const CardPaymentStatus(this.jsonString);
  final String jsonString;
}

extension CardPaymentStatusFromString on String? {
  CardPaymentStatus? get paymentMethod {
    return CardPaymentStatus.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => CardPaymentStatus.none,
    );
  }
}