import 'deposit_interest_rate_data.dart';

class DepositInterestRateResponse {
  final String responseCode;
  final String responseMessage;
  final DepositInterestRateData? data;

  DepositInterestRateResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const DepositInterestRateResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory DepositInterestRateResponse.fromJson(Map<String, dynamic> json) =>
      DepositInterestRateResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? null
            : DepositInterestRateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data?.toJson(),
      };

  @override
  String toString() => {
        "CLASS": "",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data?.toJson(),
      }.toString();
}
