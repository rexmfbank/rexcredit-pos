import 'package:equatable/equatable.dart';

class FetchLookupDataByCodeResponseData extends Equatable {
  final String code;
  final String name;
  final String description;
  final String? otherInfo;
  final String? provider;

  const FetchLookupDataByCodeResponseData({
    required this.code,
    required this.name,
    required this.description,
    this.otherInfo,
    this.provider,
  });

  const FetchLookupDataByCodeResponseData.empty()
    : code = '',
      name = '',
      description = '',
      otherInfo = '',
      provider = '';

  factory FetchLookupDataByCodeResponseData.fromJson(
    Map<String, dynamic> json,
  ) {
    return FetchLookupDataByCodeResponseData(
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      otherInfo: json['otherInfo'] as String?,
      provider: json['provider'] as String?,
    );
  }

  @override
  List<Object?> get props => [code, name, description, otherInfo, provider];
}
