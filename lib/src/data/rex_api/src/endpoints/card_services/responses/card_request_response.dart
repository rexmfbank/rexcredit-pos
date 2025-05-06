class CardRequestResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final CardResponse? data;

  CardRequestResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory CardRequestResponse.fromJson(Map<String, dynamic> json) =>
      CardRequestResponse(
        responseCode: json["responseCode"] ?? '',
        responseMessage: json["responseMessage"] ?? '',
        entityCode: json["entityCode"] ?? '',
        data: json["data"] == null ? null : CardResponse.fromJson(json["data"]),
      );
}

class CardResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? cardTokenRef;
  final String? cardId;
  final String? virtualAccountNo;
  final String? virtualAccountName;
  final String? accountId;
  final String? maskedPan;
  final String? pan;
  final DateTime? expiryDate;

  CardResponse({
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
  });

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
        responseCode: json["responseCode"] ?? '',
        responseMessage: json["responseMessage"] ?? '',
        cardTokenRef: json["cardTokenRef"] ?? '',
        cardId: json["cardId"] ?? '',
        virtualAccountNo: json["virtualAccountNo"] ?? '',
        virtualAccountName: json["virtualAccountName"] ?? '',
        accountId: json["accountId"] ?? '',
        maskedPan: json["maskedPan"] ?? '',
        pan: json["pan"] ?? '',
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.tryParse(json["expiryDate"]),
      );
}
