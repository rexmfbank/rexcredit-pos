enum BillerCategories {
  airtime('AIRTIME'),
  data('DATA'),
  cable('CABLE'),
  electricity('ELECTRICITY'),
  education('EDUCATION');

  const BillerCategories(this.jsonString);
  final String jsonString;
}

extension BillerCategoriesFromString on String? {
  BillerCategories? get billerCategories {
    return BillerCategories.values.firstWhere(
            (element) => element.jsonString == this
    );
  }
}