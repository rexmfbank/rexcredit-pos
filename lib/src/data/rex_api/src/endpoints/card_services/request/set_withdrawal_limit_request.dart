class SetCardWithdrawalLimitRequest {
  final String cardId;
  final List<CardLimitDto> cardLimitDtoList;

  SetCardWithdrawalLimitRequest({
    required this.cardId,
    required this.cardLimitDtoList,
  });

  Map<String, dynamic> toJson() => {
    "cardId": cardId,
    "cardLimitDtoList": List<dynamic>.from(cardLimitDtoList.map((x) => x.toJson())),
  };
}

class CardLimitDto {
  final String limitType;
  final double maxLimit;

  CardLimitDto({
    required this.limitType,
    required this.maxLimit,
  });

  Map<String, dynamic> toJson() => {
    "limitType": limitType,
    "maxLimit": maxLimit,
  };
}
