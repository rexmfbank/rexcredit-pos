import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class GetLoanDetailResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final GetLoanDetailResponseData? data;

  GetLoanDetailResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory GetLoanDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetLoanDetailResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null
            ? null
            : GetLoanDetailResponseData.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];
}
