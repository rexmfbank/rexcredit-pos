import 'dart:convert';

import 'package:equatable/equatable.dart';

class ListOfBanks {
  String responseCode;
  String responseMessage;
  List<BankData>? data;

  ListOfBanks({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  ListOfBanks copyWith({
    String? responseCode,
    String? responseMessage,
    List<BankData>? data,
  }) => ListOfBanks(
    responseCode: responseCode ?? this.responseCode,
    responseMessage: responseMessage ?? this.responseMessage,
    data: data ?? this.data,
  );

  factory ListOfBanks.fromRawJson(String str) =>
      ListOfBanks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListOfBanks.fromJson(Map<String, dynamic> json) => ListOfBanks(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data:
        json["data"] == null
            ? []
            : List<BankData>.from(
              json["data"]!.map((x) => BankData.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BankData extends Equatable {
  final String code;
  final String name;
  final String? description;
  final String? otherInfo;
  final String? provider;
  final num bankUptime;

  const BankData({
    required this.code,
    required this.name,
    this.description,
    this.otherInfo,
    this.provider,
    required this.bankUptime,
  });

  factory BankData.fromRawJson(String str) =>
      BankData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
    code: json["code"],
    name: json["name"],
    description: json["description"],
    otherInfo: json["otherInfo"],
    provider: json["provider"],
    bankUptime: json["bankUptime"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "description": description,
    "otherInfo": otherInfo,
    "provider": provider,
    "bankUptime": bankUptime,
  };

  @override
  List<Object?> get props => [
    code,
    name,
    description,
    otherInfo,
    provider,
    bankUptime,
  ];
}
