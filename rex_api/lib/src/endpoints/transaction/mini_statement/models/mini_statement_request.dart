import 'dart:convert';

class MiniStatementRequest {
  String? accountNo;
  String? startDate;
  String? endDate;
  String? entityCode;
  String? tranCode;
  int? pageIndex;
  int? pageSize;

  MiniStatementRequest({
    this.accountNo,
    this.startDate,
    this.endDate,
    this.entityCode,
    this.tranCode,
    this.pageIndex,
    this.pageSize,
  });

  MiniStatementRequest copyWith({
    String? accountNo,
    String? startDate,
    String? endDate,
    String? entityCode,
    String? tranCode,
    int? pageIndex,
    int? pageSize,
  }) =>
      MiniStatementRequest(
        accountNo: accountNo ?? this.accountNo,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        entityCode: entityCode ?? this.entityCode,
        tranCode: tranCode ?? this.tranCode,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
      );

  factory MiniStatementRequest.fromRawJson(String str) => MiniStatementRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MiniStatementRequest.fromJson(Map<String, dynamic> json) => MiniStatementRequest(
    accountNo: json["accountNo"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    entityCode: json["entityCode"],
    tranCode: json["tranCode"],
    pageIndex: json["pageIndex"],
    pageSize: json["pageSize"],
  );

  Map<String, dynamic> toJson() => {
    "accountNo": accountNo,
    "startDate": startDate,
    "endDate": endDate,
    "entityCode": entityCode,
    "tranCode": tranCode,
    "pageIndex": pageIndex,
    "pageSize": pageSize,
  };
}

