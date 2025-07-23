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
