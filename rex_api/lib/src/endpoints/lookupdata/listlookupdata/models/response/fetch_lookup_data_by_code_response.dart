import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/lookupdata/listlookupdata/models/response/fetch_lookup_data_by_code_response_data.dart';

class FetchLookupDataByCodeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final List<FetchLookupDataByCodeResponseData> list;

  FetchLookupDataByCodeResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.list,
  });

  FetchLookupDataByCodeResponse.empty()
      : list = [],
        responseCode = '',
        responseMessage = '';

  @override
  List<Object?> get props => [responseCode, responseMessage, list];

  factory FetchLookupDataByCodeResponse.fromJson(Map<String, dynamic> json) {
    return FetchLookupDataByCodeResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      list: json["data"] == null ? [] : List<FetchLookupDataByCodeResponseData>.from(json["data"]!.map((x) => FetchLookupDataByCodeResponseData.fromJson(x)))
    );
  }
}
