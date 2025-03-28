import 'package:rex_api/src/utils/enums/card_status.dart';

class GetCardResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final List<CardListDetails>? data;

  GetCardResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory GetCardResponse.fromJson(Map<String, dynamic> json) =>
      GetCardResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => CardListDetails.fromJson(e))
                .toList(),
      );
}

class CardListDetails {
  final String? responseCode;
  final String? responseMessage;
  final String? cardTokenRef;
  final String? cardId;
  final String? virtualAccountNo;
  final String? virtualAccountName;
  final String? accountId;
  final String? maskedPan;
  final String? pan;
  final String? cardImage;
  final DateTime? expiryDate;
  final CardStatus? cardStatus;
  final bool isActive;
  final bool isBlocked;
  final bool forcePinChange;

  CardListDetails({
    this.responseCode,
    this.responseMessage,
    this.cardTokenRef,
    this.cardId,
    this.virtualAccountNo,
    this.virtualAccountName,
    this.accountId,
    this.maskedPan,
    this.pan,
    this.cardImage,
    this.expiryDate,
    this.cardStatus,
    this.isActive = false,
    this.isBlocked = false,
    this.forcePinChange = false,
  });

  factory CardListDetails.fromJson(Map<String, dynamic> json) =>
      CardListDetails(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        cardTokenRef: json["cardTokenRef"],
        cardId: json["cardId"],
        virtualAccountNo: json["virtualAccountNo"],
        virtualAccountName: json["virtualAccountName"],
        accountId: json["accountId"],
        maskedPan: json["maskedPan"],
        pan: json["pan"],
        cardImage: json["cardImage"],
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
          cardStatus: (json["cardStatus"] as String?).cardStatus,
        isActive: json["isActive"],
        isBlocked: json["isBlocked"],
        forcePinChange: json["forcePinChange"],
      );
}
