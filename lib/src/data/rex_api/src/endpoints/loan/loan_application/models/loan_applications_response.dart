import 'package:rex_app/src/data/rex_api/rex_api.dart';

class LoanApplicationsResponse {
  final String responseCode;
  final String responseMessage;
  final List<LoanApplicationResponseData>? data;

  LoanApplicationsResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory LoanApplicationsResponse.fromJson(Map<String, dynamic> json) =>
      LoanApplicationsResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => LoanApplicationResponseData.fromJson(e))
                .toList(),
      );
}
