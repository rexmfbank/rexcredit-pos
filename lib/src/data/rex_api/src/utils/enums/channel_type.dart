enum ChannelType {
  mobile('MOBILE', 'Mobile'),
  none('NONE', 'None');

  const ChannelType(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

extension ChannelTypeFromString on String? {
  ChannelType? get channelType {
    return ChannelType.values.firstWhere(
          (element) => element.jsonString == this,
      orElse: () => ChannelType.none,
    );
  }

  ChannelType? get jsonChannelType {
    return ChannelType.values.firstWhere(
          (element) => element.displayString == this,
      orElse: () => ChannelType.none,
    );
  }
}
