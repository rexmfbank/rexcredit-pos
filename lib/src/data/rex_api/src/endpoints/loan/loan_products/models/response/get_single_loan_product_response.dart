import 'package:rex_app/src/data/rex_api/rex_api.dart';

class GetSingleLoanProductResponse {
  final String responseCode;
  final String responseMessage;
  final LoanProductModel? data;

  GetSingleLoanProductResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory GetSingleLoanProductResponse.fromJson(Map<String, dynamic> json) =>
      GetSingleLoanProductResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] != null
            ? LoanProductModel.fromJson(json['data'])
            : null,
      );
}
