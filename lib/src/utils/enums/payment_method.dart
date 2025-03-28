enum PaymentMethodRex {
  cash('CASH', 'Cash'),
  card('CARD', 'Card'),
  transfer('TRANSFER', 'Transfer'),
  ussd('USSD', 'Ussd'),
  none('NONE', 'None');

  const PaymentMethodRex(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension PaymentMethodRexFromString on String? {
  PaymentMethodRex? get paymentMethodRex {
    return PaymentMethodRex.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => PaymentMethodRex.none,
    );
  }

  PaymentMethodRex? get jsonPaymentMethod {
    return PaymentMethodRex.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => PaymentMethodRex.none,
    );
  }
}
