
import 'package:rex_api/rex_api.dart';

class ComputeLoanResponse {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final ComputeLoanResponseData? data;

  ComputeLoanResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    this.data,
  });

  factory ComputeLoanResponse.fromJson(Map<String, dynamic> json) => ComputeLoanResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    entityCode: json["entityCode"],
    data: json["data"] == null ? null : ComputeLoanResponseData.fromJson(json["data"]),
  );
}
