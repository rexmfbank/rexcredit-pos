class CreateDepositResponse {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final Object? data;

  CreateDepositResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  const CreateDepositResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory CreateDepositResponse.fromJson(Map<String, dynamic> json) =>
      CreateDepositResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data,
      };

  @override
  String toString() => {
        "CLASS": "CreateDepositResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data,
      }.toString();
}
