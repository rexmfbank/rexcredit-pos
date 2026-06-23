import 'package:rex_app/src/modules/api/models/transfer_response.dart';
import 'dart:convert';

class MiniStatementRequest {
  String? accountNo;
  String? startDate;
  String? endDate;
  String? entityCode;
  String? tranCode;
  String? transactionType;
  String? tranDesc;
  String? status;
  int? pageIndex;
  int? pageSize;

  MiniStatementRequest({
    this.accountNo,
    this.startDate,
    this.endDate,
    this.entityCode,
    this.tranCode,
    this.transactionType,
    this.status,
    this.tranDesc,
    this.pageIndex,
    this.pageSize,
  });

  MiniStatementRequest copyWith({
    String? accountNo,
    String? startDate,
    String? endDate,
    String? entityCode,
    String? tranCode,
    String? transactionType,
    String? status,
    String? tranDesc,
    int? pageIndex,
    int? pageSize,
  }) => MiniStatementRequest(
    accountNo: accountNo ?? this.accountNo,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    entityCode: entityCode ?? this.entityCode,
    tranCode: tranCode ?? this.tranCode,
    tranDesc: tranDesc ?? this.tranDesc,
    transactionType: transactionType ?? this.transactionType,
    status: status ?? this.status,
    pageIndex: pageIndex ?? this.pageIndex,
    pageSize: pageSize ?? this.pageSize,
  );

  factory MiniStatementRequest.fromRawJson(String str) =>
      MiniStatementRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MiniStatementRequest.fromJson(Map<String, dynamic> json) =>
      MiniStatementRequest(
        accountNo: json["accountNo"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        entityCode: json["entityCode"],
        tranCode: json["tranCode"],
        tranDesc: json["tranDesc"],
        transactionType: json["transactionType"],
        status: json["status"],
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
    "accountNo": accountNo,
    "startDate": startDate,
    "endDate": endDate,
    "entityCode": entityCode,
    "tranCode": tranCode,
    "transactionType": transactionType,
    "status": status,
    "tranDesc": tranDesc,
    "pageIndex": pageIndex,
    "pageSize": pageSize,
  };
}

class MiniStatementResponse {
  String responseCode;
  String responseMessage;
  List<TransferData>? data;
  int pageIndex;
  int pageSize;
  int totalPages;
  bool hasNextPage;
  bool hasPreviousPage;
  int totalContent;

  MiniStatementResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
    required this.pageIndex,
    required this.pageSize,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.totalContent,
  });

  MiniStatementResponse.empty()
    : responseCode = '',
      responseMessage = '',
      data = null,
      pageIndex = 0,
      pageSize = 0,
      totalPages = 0,
      hasNextPage = false,
      hasPreviousPage = false,
      totalContent = 0;

  MiniStatementResponse copyWith({
    String? responseCode,
    String? responseMessage,
    List<TransferData>? data,
    int? pageIndex,
    int? pageSize,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPreviousPage,
    int? totalContent,
  }) => MiniStatementResponse(
    responseCode: responseCode ?? this.responseCode,
    responseMessage: responseMessage ?? this.responseMessage,
    data: data ?? this.data,
    pageIndex: pageIndex ?? this.pageIndex,
    pageSize: pageSize ?? this.pageSize,
    totalPages: totalPages ?? this.totalPages,
    hasNextPage: hasNextPage ?? this.hasNextPage,
    hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    totalContent: totalContent ?? this.totalContent,
  );

  factory MiniStatementResponse.fromJson(Map<String, dynamic> json) {
    return MiniStatementResponse(
      responseCode: json["responseCode"] as String,
      responseMessage: json["responseMessage"] as String,
      data:
          json["data"] == null
              ? []
              : List<TransferData>.from(
                json["data"]!.map((x) => TransferData.fromJson(x)),
              ),
      pageIndex: json['pageIndex'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
      totalContent: json['totalContent'] as int,
    );
  }
}
