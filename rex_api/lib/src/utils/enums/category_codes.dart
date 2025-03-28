enum CategoryCode {
  codeBlockReasonCode('CARD_BLOCK_REASON_CODE'),
  none('NONE');

  const CategoryCode(this.jsonString);
  final String jsonString;
}

extension CategoryCodeFromString on String? {
  CategoryCode? get categoryCode {
    return CategoryCode.values.firstWhere(
            (element) => element.jsonString == this
    );
  }
}