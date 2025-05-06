import 'deposit_data.dart';

class DepositList {
  final String responseCode;
  final String responseMessage;
  final List<DepositData>? data;

  const DepositList({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const DepositList.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory DepositList.fromJson(Map<String, dynamic> json) => DepositList(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? []
            : List<DepositData>.from(
                json["data"].map((x) => DepositData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  String toString() => {
        "CLASS": "DepositList",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data == null ? [] : data!.map((x) => x.toJson()).toList(),
      }.toString();
}
