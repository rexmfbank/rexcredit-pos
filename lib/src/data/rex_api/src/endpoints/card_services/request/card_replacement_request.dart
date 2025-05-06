class CardReplacementRequest {
  final String reason;
  final String cardId;
  final String externalRefNo;
  final String cardPin;

  CardReplacementRequest({
    required this.reason,
    required this.cardId,
    required this.externalRefNo,
    required this.cardPin,
  });

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "cardId": cardId,
    "externalRefNo": externalRefNo,
    "cardPin": cardPin,
  };
}
