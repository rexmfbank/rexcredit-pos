enum DeviceType {
  mobile('MOBILE', 'Mobile'),
  pos('POS', 'Pos'),
  none('NONE', 'None');

  const DeviceType(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension DeviceTypeFromString on String? {
  DeviceType? get deviceType {
    return DeviceType.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => DeviceType.none,
    );
  }

  DeviceType? get jsonPaymentMethod {
    return DeviceType.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => DeviceType.none,
    );
  }
}
