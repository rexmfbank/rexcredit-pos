import 'package:rex_app/src/modules/revamp/api/models/transfer_response.dart';

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
