import 'package:equatable/equatable.dart';

class DisputeReasonItem extends Equatable {
  final String code;
  final String label;

  const DisputeReasonItem({required this.code, required this.label});

  factory DisputeReasonItem.fromJson(Map<String, dynamic> json) =>
      DisputeReasonItem(
        code: json["code"] ?? '',
        label: json["label"] ?? '',
      );

  Map<String, dynamic> toJson() => {"code": code, "label": label};

  @override
  List<Object?> get props => [code, label];
}

class CreateDisputeRequest extends Equatable {
  final String transUniqueRef;
  final String rrn;
  final num amount;
  final String disputeReason;
  final String description;

  const CreateDisputeRequest({
    required this.transUniqueRef,
    required this.rrn,
    required this.amount,
    required this.disputeReason,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    "transUniqueRef": transUniqueRef,
    "rrn": rrn,
    "amount": amount,
    "disputeReason": disputeReason,
    "description": description,
  };

  @override
  List<Object?> get props => [
    transUniqueRef,
    rrn,
    amount,
    disputeReason,
    description,
  ];
}

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
        responseCode: json["responseCode"]?.toString() ?? '',
        responseMessage: json["responseMessage"]?.toString() ?? '',
        entityCode: json["entityCode"],
        data:
            json["data"] == null
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
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];
}

class DisputeResponseData extends Equatable {
  final String? disputeId;
  final String? transUniqueRef;
  final String? rrn;
  final num? amount;
  final String? disputeReason;
  final String? description;
  final String? status;
  final String? createdAt;

  const DisputeResponseData({
    this.disputeId,
    this.transUniqueRef,
    this.rrn,
    this.amount,
    this.disputeReason,
    this.description,
    this.status,
    this.createdAt,
  });

  const DisputeResponseData.empty()
    : disputeId = null,
      transUniqueRef = null,
      rrn = null,
      amount = null,
      disputeReason = null,
      description = null,
      status = null,
      createdAt = null;

  factory DisputeResponseData.fromJson(Map<String, dynamic> json) =>
      DisputeResponseData(
        disputeId: json["disputeId"]?.toString(),
        transUniqueRef: json["transUniqueRef"]?.toString(),
        rrn: json["rrn"]?.toString(),
        amount: json["amount"],
        disputeReason: json["disputeReason"],
        description: json["description"],
        status: json["status"],
        createdAt: json["createdAt"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "disputeId": disputeId,
    "transUniqueRef": transUniqueRef,
    "rrn": rrn,
    "amount": amount,
    "disputeReason": disputeReason,
    "description": description,
    "status": status,
    "createdAt": createdAt,
  };

  @override
  List<Object?> get props => [
    disputeId,
    transUniqueRef,
    rrn,
    amount,
    disputeReason,
    description,
    status,
    createdAt,
  ];
}
