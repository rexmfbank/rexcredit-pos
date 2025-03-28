class BillerCategoriesQuery {
  String? countryCode;
  String? entityCode;

  BillerCategoriesQuery({
    this.countryCode,
    this.entityCode,
  });

  BillerCategoriesQuery copyWith({
    String? countryCode,
    String? entityCode,
  }) {
    return BillerCategoriesQuery(
      countryCode: countryCode ?? this.countryCode,
      entityCode: entityCode ?? this.entityCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countryCode': countryCode,
      'entityCode': entityCode,
    };
  }

  factory BillerCategoriesQuery.fromMap(Map<String, dynamic> map) {
    return BillerCategoriesQuery(
      countryCode: map['countryCode'],
      entityCode: map['entityCode'],
    );
  }
}