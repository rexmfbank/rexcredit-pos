class ActivateCardResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final CardInfo? data;

  ActivateCardResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory ActivateCardResponse.fromJson(Map<String, dynamic> json) => ActivateCardResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    entityCode: json["entityCode"],
    data: json["data"] == null ? null : CardInfo.fromJson(json["data"]),
  );
}

class CardInfo {
  final String? cardId;
  final String? action;
  final String? comment;
  final String? responseMessage;
  final String? responseCode;

  CardInfo({
    this.cardId,
    this.action,
    this.comment,
    this.responseMessage,
    this.responseCode,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) => CardInfo(
    cardId: json["cardId"],
    action: json["action"],
    comment: json["comment"],
    responseMessage: json["responseMessage"],
    responseCode: json["responseCode"],
  );
}
