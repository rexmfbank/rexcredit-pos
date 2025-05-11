enum CategoryStatus {
  active('ACTIVE', 'Active'),
  inactive('INACTIVE', 'InActive'),
  none('NONE', 'None');

  const CategoryStatus(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension CategoryStatusFromString on String? {
  CategoryStatus? get categoryStatus {
    return CategoryStatus.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => CategoryStatus.none,
    );
  }

  CategoryStatus? get jsonCategoryStatus {
    return CategoryStatus.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => CategoryStatus.none,
    );
  }
}
