class CardRequest {
  final String accountNo;
  final String cardType;
  final String deliveryOption;
  final String address;
  final String city;
  final String state;
  final String cardProductCode;
  final String cardName;
  final String reference;
  final String externalReferenceNo;

  CardRequest({
    required this.accountNo,
    required this.cardType,
    required this.deliveryOption,
    required this.address,
    required this.city,
    required this.state,
    required this.cardProductCode,
    required this.cardName,
    required this.reference,
    required this.externalReferenceNo,
  });

  Map<String, dynamic> toJson() => {
    "accountNo": accountNo,
    "cardType": cardType,
    "deliveryOption": deliveryOption,
    "address": address,
    "city": city,
    "state": state,
    "cardProductCode": cardProductCode,
    "cardName": cardName,
    "reference": reference,
    "externalReferenceNo": externalReferenceNo,
  };
}
