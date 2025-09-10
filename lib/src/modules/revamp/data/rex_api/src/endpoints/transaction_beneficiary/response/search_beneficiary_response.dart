import '../../bill_payment/models/response/fetch_beneficiary_response.dart';

class SearchBeneficiaryResponse {
  String responseCode;
  String responseMessage;
  BeneficiaryData? data;

  SearchBeneficiaryResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory SearchBeneficiaryResponse.fromJson(Map<String, dynamic> json) => SearchBeneficiaryResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : BeneficiaryData.fromJson(json["data"]),
  );
}