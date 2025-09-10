class AppCountry {
  final String code;
  final String name;
  final String description;
  final Object? otherInfo;
  final Object? provider;
  final String? url;
  bool isSelected;

  AppCountry({
    required this.code,
    required this.name,
    required this.description,
    this.otherInfo,
    this.provider,
    this.url,
    this.isSelected = false,
  });

  AppCountry.empty()
      : code = '',
        name = '',
        description = '',
        otherInfo = null,
        provider = null,
        url = '',
        isSelected = false;

  factory AppCountry.fromJson(Map<String, dynamic> json) {
    return AppCountry(
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      otherInfo: json['otherInfo'],
      provider: json['provider'],
      url: json['url'],
    );
  }
}
