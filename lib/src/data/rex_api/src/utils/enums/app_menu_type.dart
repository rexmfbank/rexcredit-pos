enum AppMenuType {
  loan('LOAN', 'Loan'),
  internalTransfer('INTERNAL_TRANSFER', 'Internal Transfer'),
  spend('SPEND', 'Spend'),
  interbank('INTERBANK', 'InterBank'),
  acd('ACD', 'Acd'),
  airtime('AIRTIME', 'Airtime'),
  billPayment('BILL_PAYMENT', 'Bill Payment'),
  data('DATA_PLAN', 'Data Plan'),
  electricity('ELECTRICITY', 'Electricity'),
  cable('CABLE_TV', 'Cable TV'),
  none('NONE', 'None');

  const AppMenuType(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension AppMenuTypeFromString on String? {
  AppMenuType? get jsonAppMenuType {
    return AppMenuType.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => AppMenuType.none,
    );
  }

  AppMenuType? get displayMenuMethod {
    return AppMenuType.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => AppMenuType.none,
    );
  }
}
