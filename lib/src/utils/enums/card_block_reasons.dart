enum CardBlockReason {
  fraud('FRAUD', 'Fraud'),
  personalReasons('PERSONAL_REASONS', 'Personal Reasons'),
  none('NONE', 'None');

  const CardBlockReason(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension CardBlockReasonFromString on String? {
  CardBlockReason? get cardBlockReason {
    return CardBlockReason.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => CardBlockReason.none,
    );
  }

  CardBlockReason? get jsonPaymentMethod {
    return CardBlockReason.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => CardBlockReason.none,
    );
  }
}
