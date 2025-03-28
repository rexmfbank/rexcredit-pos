class ActivateCardRequest {
  final String cardNumber;
  final String cvv;
  final String expiryDate;

  ActivateCardRequest({
    required this.cardNumber,
    required this.cvv,
    required this.expiryDate,
  });

  Map<String, dynamic> toJson() => {
    "cardNumber": cardNumber,
    "cvv": cvv,
    "expiryDate": expiryDate,
  };
}
