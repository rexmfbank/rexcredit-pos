enum PaymentMethod {
  cash('CASH', 'Cash'),
  card('CARD', 'Card'),
  transfer('TRANSFER', 'Transfer'),
  ussd('USSD', 'Ussd'),
  none('NONE', 'None');

  const PaymentMethod(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension PaymentMethodFromString on String? {
  PaymentMethod? get paymentMethod {
    return PaymentMethod.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => PaymentMethod.none,
    );
  }

  PaymentMethod? get displayPaymentMethod {
    return PaymentMethod.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => PaymentMethod.none,
    );
  }
}
