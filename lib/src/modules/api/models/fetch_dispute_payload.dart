import 'package:equatable/equatable.dart';

class FetchDisputeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final FetchDisputePage? data;

  const FetchDisputeResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory FetchDisputeResponse.fromJson(Map<String, dynamic> json) =>
      FetchDisputeResponse(
        responseCode: json["responseCode"] ?? '',
        responseMessage: json["responseMessage"] ?? '',
        entityCode: json["entityCode"],
        data:
            json["data"] == null
                ? null
                : FetchDisputePage.fromJson(json["data"]),
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

class FetchDisputePage extends Equatable {
  final List<FetchDisputeData> items;
  final DisputePageMeta? meta;

  const FetchDisputePage({this.items = const [], this.meta});

  factory FetchDisputePage.fromJson(Map<String, dynamic> json) =>
      FetchDisputePage(
        items:
            json["items"] == null
                ? []
                : List<FetchDisputeData>.from(
                  json["items"].map((x) => FetchDisputeData.fromJson(x)),
                ),
        meta:
            json["meta"] == null ? null : DisputePageMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
    "items": items.map((x) => x.toJson()).toList(),
    "meta": meta?.toJson(),
  };

  @override
  List<Object?> get props => [items, meta];
}

class DisputePageMeta extends Equatable {
  final int? pageIndex;
  final int? pageSize;
  final int? totalPages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final int? totalContent;

  const DisputePageMeta({
    this.pageIndex,
    this.pageSize,
    this.totalPages,
    this.hasNextPage,
    this.hasPreviousPage,
    this.totalContent,
  });

  factory DisputePageMeta.fromJson(Map<String, dynamic> json) =>
      DisputePageMeta(
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
        totalPages: json["totalPages"],
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
        totalContent: json["totalContent"],
      );

  Map<String, dynamic> toJson() => {
    "pageIndex": pageIndex,
    "pageSize": pageSize,
    "totalPages": totalPages,
    "hasNextPage": hasNextPage,
    "hasPreviousPage": hasPreviousPage,
    "totalContent": totalContent,
  };

  @override
  List<Object?> get props => [
    pageIndex,
    pageSize,
    totalPages,
    hasNextPage,
    hasPreviousPage,
    totalContent,
  ];
}

class FetchDisputeData extends Equatable {
  final String? disputeId;
  final String? transUniqueRef;
  final String? rrn;
  final num? amount;
  final String? disputeReason;
  final String? description;
  final String? status;
  final String? createdAt;

  const FetchDisputeData({
    this.disputeId,
    this.transUniqueRef,
    this.rrn,
    this.amount,
    this.disputeReason,
    this.description,
    this.status,
    this.createdAt,
  });

  factory FetchDisputeData.fromJson(Map<String, dynamic> json) =>
      FetchDisputeData(
        disputeId: json["disputeId"]?.toString(),
        transUniqueRef: json["transUniqueRef"],
        rrn: json["rrn"],
        amount: json["amount"],
        disputeReason: json["disputeReason"],
        description: json["description"],
        status: json["status"],
        createdAt: json["createdAt"]?.toString(),
      );

  DateTime? get createdAtDate =>
      createdAt == null ? null : DateTime.tryParse(createdAt!);

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
