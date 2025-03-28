import 'package:equatable/equatable.dart';

class CreateDisputeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final DisputeResponseData? data;

  const CreateDisputeResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  const CreateDisputeResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory CreateDisputeResponse.fromJson(Map<String, dynamic> json) =>
      CreateDisputeResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null
            ? null
            : DisputeResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}

class DisputeResponseData extends Equatable {
  final List<int>? disputedDate;
  final String? status;
  final String? transactionId;
  final String? disputeMessage;

  const DisputeResponseData({
    this.disputedDate,
    this.status,
    this.transactionId,
    this.disputeMessage,
  });

  const DisputeResponseData.empty()
      : disputedDate = null,
        status = null,
        transactionId = null,
        disputeMessage = null;

  factory DisputeResponseData.fromJson(Map<String, dynamic> json) =>
      DisputeResponseData(
        disputedDate: json["disputedDate"] == null
            ? []
            : List<int>.from(json["disputedDate"].map((x) => x)),
        status: json["status"],
        transactionId: json["transactionId"],
        disputeMessage: json["disputeMessage"],
      );

  Map<String, dynamic> toJson() => {
        "disputedDate": disputedDate == null
            ? []
            : List<dynamic>.from(disputedDate!.map((x) => x)),
        "status": status,
        "transactionId": transactionId,
        "disputeMessage": disputeMessage,
      };

  @override
  String toString() => {
        "CLASS": "DisputeResponseData",
        "disputedDate": disputedDate,
        "status": status,
        "transactionId": transactionId,
        "disputeMessage": disputeMessage,
      }.toString();

  @override
  List<Object?> get props => [
        disputedDate,
        status,
        transactionId,
        disputeMessage,
      ];
}
