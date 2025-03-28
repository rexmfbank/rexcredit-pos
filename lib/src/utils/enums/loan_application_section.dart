enum LoanSection {
  loan('LOAN', 'loan'),
  guarantor('GUARANTOR', 'guarantor'),
  employer('EMPLOYER', 'employer');

  const LoanSection(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}
