import 'package:equatable/equatable.dart';

class FetchDisputeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final List<FetchDisputeData>? data;

  const FetchDisputeResponse({
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
        data:
            json["data"] == null
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
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];
}

class FetchDisputeData extends Equatable {
  final List<int>? disputedDate;
  final String? status;
  final String? transactionId;
  final String? disputeMessage;

  const FetchDisputeData({
    this.disputedDate,
    this.status,
    this.transactionId,
    this.disputeMessage,
  });

  factory FetchDisputeData.fromJson(Map<String, dynamic> json) =>
      FetchDisputeData(
        disputedDate:
            json["disputedDate"] == null
                ? []
                : List<int>.from(json["disputedDate"].map((x) => x)),
        status: json["status"],
        transactionId: json["transactionId"],
        disputeMessage: json["disputeMessage"],
      );

  Map<String, dynamic> toJson() => {
    "disputedDate":
        disputedDate == null ? [] : disputedDate?.map((x) => x).toList(),
    "status": status,
    "transactionId": transactionId,
    "disputeMessage": disputeMessage,
  };

  @override
  List<Object?> get props => [
    disputedDate,
    status,
    transactionId,
    disputeMessage,
  ];
}
