enum CardType {
  credit('CREDIT', 'Credit Card'),
  debit('DEBIT', 'Debit Card'),
  none('NONE', 'None');

  const CardType(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension CardTypeFromString on String? {
  CardType? get cardType {
    return CardType.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => CardType.none,
    );
  }

  CardType? get jsonPaymentMethod {
    return CardType.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => CardType.none,
    );
  }
}
