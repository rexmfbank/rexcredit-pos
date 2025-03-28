enum DeliveryOption {
  delivery('DELIVERY', 'Delivery'),
  pickup('PICKUP', 'Pickup'),
  none('NONE', 'None');

  const DeliveryOption(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension DeliveryOptionFromString on String? {
  DeliveryOption? get deliveryOption {
    return DeliveryOption.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => DeliveryOption.none,
    );
  }

  DeliveryOption? get jsonPaymentMethod {
    return DeliveryOption.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => DeliveryOption.none,
    );
  }
}
