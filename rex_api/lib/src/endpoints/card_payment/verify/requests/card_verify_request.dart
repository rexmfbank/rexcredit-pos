class CardVerifyRequest {
  final String reference;

  CardVerifyRequest({
    required this.reference,
  });

  Map<String, dynamic> toJson() => {
        "reference": reference,
      };
}
