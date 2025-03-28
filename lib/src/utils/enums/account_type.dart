enum AccountType {
  individual('individual', 'Individual', 'INDIVIDUAL'),
  business('business', 'Business', 'BUSINESS'),
  none('none', 'None', 'NONE');

  const AccountType(
    this.jsonString,
    this.displayString,
    this.requestString,
  );
  final String jsonString;
  final String displayString;
  final String requestString;
}

extension AccountTypeFromString on String? {
  AccountType? get jsonAccountType {
    return AccountType.values.firstWhere(
      (element) => element.jsonString == this,
      orElse: () => AccountType.none,
    );
  }

  AccountType? get displayAccountType {
    return AccountType.values.firstWhere(
      (element) => element.displayString == this,
      orElse: () => AccountType.none,
    );
  }
}
