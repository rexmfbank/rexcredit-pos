import 'package:rex_app/src/data/rex_api/rex_api.dart';

class GetLoanProductsResponse {
  final String responseCode;
  final String responseMessage;
  final List<LoanProductModel>? data;

  GetLoanProductsResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory GetLoanProductsResponse.fromJson(Map<String, dynamic> json) =>
      GetLoanProductsResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => LoanProductModel.fromJson(e))
                .toList(),
      );
}
