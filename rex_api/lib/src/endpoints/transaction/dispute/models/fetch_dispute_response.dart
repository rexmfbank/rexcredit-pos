import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/transaction/dispute/models/fetch_dispute_data.dart';

class FetchDisputeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final List<FetchDisputeData>? data;

  FetchDisputeResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory FetchDisputeResponse.fromJson(Map<String, dynamic> json) =>
      FetchDisputeResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null
            ? []
            : List<FetchDisputeData>.from(
                json["data"].map((x) => FetchDisputeData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data == null ? [] : data?.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}
