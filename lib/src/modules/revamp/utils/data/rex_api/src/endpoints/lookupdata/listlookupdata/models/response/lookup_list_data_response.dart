class LookUpListDataResponse {
  final String responseCode;
  final String responseMessage;
  final List<LookUpListInfo>? data;

  LookUpListDataResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory LookUpListDataResponse.fromJson(Map<String, dynamic> json) =>
      LookUpListDataResponse(
        responseCode: json['responseCode'] as String,
        responseMessage: json['responseMessage'] as String,
        data: json["data"] == null
            ? null
            : (json["data"] as List)
            .map((e) => LookUpListInfo.fromJson(e))
            .toList(),
      );
}

class LookUpListInfo {
  final String? code;
  final String? name;
  final String? description;
  final String? otherInfo;
  final String? provider;

  LookUpListInfo({
    this.code,
    this.name,
    this.description,
    this.otherInfo,
    this.provider,
  });

  factory LookUpListInfo.fromJson(Map<String, dynamic> json) => LookUpListInfo(
    code: json["code"] ?? '',
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    otherInfo: json["otherInfo"] ?? '',
    provider: json["provider"] ?? '',
  );
}
