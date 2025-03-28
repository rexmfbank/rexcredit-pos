import 'package:rex_api/rex_api.dart';

class SaveKycDocsResponse {
  final String responseCode;
  final String responseMessage;
  final KycDocInfo? data;

  SaveKycDocsResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory SaveKycDocsResponse.fromJson(Map<String, dynamic> json) =>
      SaveKycDocsResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null ? null : KycDocInfo.fromJson(json["data"]),
      );
}
