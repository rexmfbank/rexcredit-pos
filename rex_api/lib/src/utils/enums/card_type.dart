enum CardType {
  credit('CREDIT', 'Credit'),
  debit('DEBIT', 'Debit'),
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

  CardType? get jsonCardMethod {
    return CardType.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => CardType.none,
    );
  }
}
