class SetCardWithdrawalResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final WithdrawalResponse? data;

  SetCardWithdrawalResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory SetCardWithdrawalResponse.fromJson(Map<String, dynamic> json) => SetCardWithdrawalResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    entityCode: json["entityCode"],
    data: json["data"] == null ? null : WithdrawalResponse.fromJson(json["data"]),
  );
}

class WithdrawalResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? cardId;
  final String? posLimit;
  final String? webLimit;
  final String? atmLimit;
  final String? contactlessLimit;

  WithdrawalResponse({
    this.responseCode,
    this.responseMessage,
    this.cardId,
    this.posLimit,
    this.webLimit,
    this.atmLimit,
    this.contactlessLimit,
  });

  factory WithdrawalResponse.fromJson(Map<String, dynamic> json) => WithdrawalResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    cardId: json["cardId"],
    posLimit: json["posLimit"],
    webLimit: json["webLimit"],
    atmLimit: json["atmLimit"],
    contactlessLimit: json["contactlessLimit"],
  );

}
