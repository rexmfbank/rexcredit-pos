enum CardStatus {
  active('ACTIVE', 'Active'),
  lost('LOST', 'Lost'),
  stolen('STOLEN', 'Stolen'),
  suspended('SUSPENDED', 'Suspended'),
  cardCreatedPendingPinChange('CARD_CREATED_PENDING_PIN_CHANGE', 'Created Pending Pin Change'),
  cardHolderSaved('CARD_HOLDER_SAVED', 'Created Holder Saved'),
  cardHolderCreated('CARD_HOLDER_CREATED', 'Created Holder Created'),
  cardSaved('CARD_SAVED', 'Card Saved'),
  cardCreated('CARD_CREATED', 'Card Created'),
  none('NONE', 'None');

  const CardStatus(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension CardStatusFromString on String? {
  CardStatus? get cardStatus {
    return CardStatus.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => CardStatus.none,
    );
  }

  CardStatus? get jsonCardStatus {
    return CardStatus.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => CardStatus.none,
    );
  }
}
