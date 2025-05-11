class RexResponseTemplate {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final dynamic data;

  RexResponseTemplate({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory RexResponseTemplate.fromJson(Map<String, dynamic> json) => RexResponseTemplate(
    responseCode: json["responseCode"] ?? '',
    responseMessage: json["responseMessage"] ?? '',
    entityCode: json["entityCode"] ?? '',
    data: json["data"],
  );

}
