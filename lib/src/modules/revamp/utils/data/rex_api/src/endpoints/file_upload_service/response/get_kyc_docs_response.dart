import '../../../utils/enums/doc_status.dart';

import 'package:equatable/equatable.dart';

class GetKycDocsResponse {
  final String responseCode;
  final String responseMessage;
  final List<KycDocInfo>? data;

  GetKycDocsResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory GetKycDocsResponse.fromJson(Map<String, dynamic> json) =>
      GetKycDocsResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => KycDocInfo.fromJson(e))
                .toList(),
      );
}

class KycDocInfo extends Equatable {
  final String? documentTitle;
  final String? documentType;
  final String? documentText;
  final String? referenceNoRequired;
  final String? referenceNoTitle;
  final String? status;
  final String? documentLink;

  KycDocInfo({
    this.documentTitle,
    this.documentType,
    this.documentText,
    this.referenceNoRequired,
    this.referenceNoTitle,
    this.status,
    this.documentLink,
  });

  factory KycDocInfo.fromJson(Map<String, dynamic> json) => KycDocInfo(
        documentTitle: json["documentTitle"],
        documentType: json["documentType"],
        documentText: json["documentText"],
        referenceNoRequired: json["referenceNoRequired"],
        referenceNoTitle: json["referenceNoTitle"],
        status: json["status"],
        documentLink: json["documentLink"],
      );

  @override
  List<Object?> get props => [
        documentTitle,
        documentType,
        documentText,
        referenceNoRequired,
        referenceNoTitle,
        status,
        documentLink
      ];
}
