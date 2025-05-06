import 'package:rex_app/src/data/rex_api/rex_api.dart';

class LoanApplicationGeneralResponse {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final LoanApplicationResponseData? data;

  LoanApplicationGeneralResponse({
    required this.responseCode,
    this.entityCode,
    required this.responseMessage,
    this.data,
  });

  factory LoanApplicationGeneralResponse.fromJson(Map<String, dynamic> json) =>
      LoanApplicationGeneralResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? null
            : LoanApplicationResponseData.fromJson(json['data']),
      );
}
