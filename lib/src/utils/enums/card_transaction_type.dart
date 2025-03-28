enum CardTransactionType {
  purchase('PURCHASE');

  const CardTransactionType(this.jsonString);
  final String jsonString;
}