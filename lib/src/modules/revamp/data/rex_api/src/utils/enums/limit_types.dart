enum LimitTypes {
  atmLimit('ATM_LIMIT', 'Atm Limit'),
  posLimit('POS_LIMIT', 'Pos Limit'),
  webLimit('WEB_LIMIT', 'Web Limit'),
  none('NONE', 'None');

  const LimitTypes(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension LimitTypesFromString on String? {
  LimitTypes? get limitTypes {
    return LimitTypes.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => LimitTypes.none,
    );
  }

  LimitTypes? get jsonLimitTypes {
    return LimitTypes.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => LimitTypes.none,
    );
  }
}
