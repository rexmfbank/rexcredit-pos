class ChangeCardPinRequest {
  final String cardId;
  final String otp;
  final String oldPin;
  final String newPin;

  ChangeCardPinRequest({
    required this.cardId,
    required this.otp,
    required this.oldPin,
    required this.newPin,
  });

  Map<String, dynamic> toJson() => {
    "cardId": cardId,
    "otp": otp,
    "oldPin": oldPin,
    "newPin": newPin,
  };
}
