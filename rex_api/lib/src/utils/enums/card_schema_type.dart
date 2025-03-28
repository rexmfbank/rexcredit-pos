enum CardSchemaType {
  americanExpress('AMERICAN_EXPRESS', 'American Express'),
  discover('DISCOVER', 'Discover'),
  jcb('JCB', 'Jcb'),
  visa('VISA', 'Visa'),
  masterCard('MASTERCARD', 'Mastercard'),
  verve('VERVE', 'Verve'),
  dinersClub('DINERS_CLUB', 'Diners Club'),
  none('NONE', 'None');

  const CardSchemaType(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension CardSchemaTypeFromString on String? {
  CardSchemaType? get cardSchemaType {
    return CardSchemaType.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => CardSchemaType.none,
    );
  }

  CardSchemaType? get jsonCardSchemaType {
    return CardSchemaType.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => CardSchemaType.none,
    );
  }
}
