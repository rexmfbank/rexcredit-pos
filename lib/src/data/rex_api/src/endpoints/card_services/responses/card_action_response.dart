class CardActionResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final CardAction? data;

  CardActionResponse({
     this.responseCode,
     this.responseMessage,
     this.entityCode,
     this.data,
  });

  factory CardActionResponse.fromJson(Map<String, dynamic> json) => CardActionResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    entityCode: json["entityCode"],
    data: json["data"] == null ? null : CardAction.fromJson(json["data"]),
  );
}

class CardAction {
  final String? cardId;
  final String? action;
  final String? comment;
  final String? responseMessage;
  final String? responseCode;

  CardAction({
     this.cardId,
     this.action,
     this.comment,
     this.responseMessage,
     this.responseCode,
  });

  factory CardAction.fromJson(Map<String, dynamic> json) => CardAction(
    cardId: json["cardId"] ?? '',
    action: json["action"] ?? '',
    comment: json["comment"] ?? '',
    responseMessage: json["responseMessage"] ?? '',
    responseCode: json["responseCode"] ?? '',
  );
}
