enum DocType {
  passport('PASSPORT', 'Passport'),
  utility('UTILITY', 'Utility'),
  id('ID', 'Id'),
  bvn('BVN', 'Bvn'),
  nin('NIN', 'National Identification Number (NIN)'),
  bid('BID', 'Business Identification'), // This is for CAC
  dirid('DIRID', 'Director ID'),
  dirpass('DIRPASS', 'Director Passport'),
  dirnin('DIRNIN', 'Director NIN'),
  identitydocument('IDENTIFICATION_DOCUMENT', 'identity document'),
  none('NONE', 'None');

  const DocType(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension DocTypeFromString on String? {
  DocType? get jsonDocType {
    return DocType.values.firstWhere(
      (element) => element.jsonString == this,
      orElse: () => DocType.none,
    );
  }

  DocType? get displayDocTypeMethod {
    return DocType.values.firstWhere(
      (element) => element.displayString == this,
      orElse: () => DocType.none,
    );
  }
}
