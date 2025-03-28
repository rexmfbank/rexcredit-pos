enum PayrollItemTypes {
  allowance('ALLOWANCE', 'Allowance'),
  deduction('DEDUCTION', 'Deduction'),
  none('NONE', 'None');

  const PayrollItemTypes(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension PayrollItemTypesFromString on String? {
  PayrollItemTypes? get payrollItemTypes {
    return PayrollItemTypes.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => PayrollItemTypes.none,
    );
  }

  PayrollItemTypes? get displayPayrollItemTypes {
    return PayrollItemTypes.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => PayrollItemTypes.none,
    );
  }
}
