class CardActionRequest {
  final String cardId;
  final String reason;

  CardActionRequest({
    required this.cardId,
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
    "cardId": cardId,
    "reason": reason,
  };
}
