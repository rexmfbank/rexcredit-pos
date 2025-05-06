import 'deposit_interest_type_data.dart';

class DepositInterestType {
  final String responseCode;
  final String responseMessage;
  final List<DepositInterestTypeData>? data;

  const DepositInterestType({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const DepositInterestType.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory DepositInterestType.fromJson(Map<String, dynamic> json) =>
      DepositInterestType(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? null
            : List<DepositInterestTypeData>.from(
                json["data"].map((x) => DepositInterestTypeData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data == null ? [] : data?.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() => {
        "CLASS": "DepositInterestType",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data == null ? [] : data?.map((x) => x.toJson()).toList(),
      }.toString();
}
