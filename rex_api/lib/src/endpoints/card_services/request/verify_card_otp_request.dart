class VerifyCardOtpRequest {
  final String cardId;
  final String otp;

  VerifyCardOtpRequest({
    required this.cardId,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    "cardId": cardId,
    "otp": otp,
  };
}
