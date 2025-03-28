import 'package:rex_api/src/utils/enums/card_status.dart';

class CardReplacementResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final CardReplacementInfo? data;

  CardReplacementResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory CardReplacementResponse.fromJson(Map<String, dynamic> json) => CardReplacementResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    entityCode: json["entityCode"],
    data: json["data"] == null ? null : CardReplacementInfo.fromJson(json["data"]),
  );
}

class CardReplacementInfo {
  final String? responseCode;
  final String? responseMessage;
  final String? cardTokenRef;
  final String? cardId;
  final String? virtualAccountNo;
  final String? virtualAccountName;
  final String? accountId;
  final String? maskedPan;
  final String? pan;
  final String? expiryDate;
  final CardStatus? cardStatus;
  final bool? isActive;
  final bool? isBlocked;
  final String? cardImage;
  final bool? forcePinChange;

  CardReplacementInfo({
    this.responseCode,
    this.responseMessage,
    this.cardTokenRef,
    this.cardId,
    this.virtualAccountNo,
    this.virtualAccountName,
    this.accountId,
    this.maskedPan,
    this.pan,
    this.expiryDate,
    this.cardStatus,
    this.isActive,
    this.isBlocked,
    this.cardImage,
    this.forcePinChange,
  });

  factory CardReplacementInfo.fromJson(Map<String, dynamic> json) => CardReplacementInfo(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    cardTokenRef: json["cardTokenRef"],
    cardId: json["cardId"],
    virtualAccountNo: json["virtualAccountNo"],
    virtualAccountName: json["virtualAccountName"],
    accountId: json["accountId"],
    maskedPan: json["maskedPan"],
    pan: json["pan"],
    expiryDate: json["expiryDate"],
    cardStatus: (json["cardStatus"] as String?).jsonCardStatus,
    isActive: json["isActive"],
    isBlocked: json["isBlocked"],
    cardImage: json["cardImage"],
    forcePinChange: json["forcePinChange"],
  );
}
