import '../../../utils/enums/control_types.dart';
import '../../../utils/enums/enums.dart';

class GetCardDetailsResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final CardDetails? data;

  GetCardDetailsResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory GetCardDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetCardDetailsResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null ? null : CardDetails.fromJson(json["data"]),
      );
}

class CardDetails {
  final String? responseCode;
  final String? responseMessage;
  final String? cardTokenRef;
  final String? cardId;
  final String? fullCardNumber;
  final String? maskedPan;
  final DateTime? expiryDate;
  final String? cvv;
  final String? nameOnCard;
  final String? cardType;
  final String? cardLogo;
  final CardStatus? cardStatus;
  final List<CardControl>? cardControls;
  final List<Limit>? limits;
  final ProductsInfo? product;

  CardDetails({
    this.responseCode,
    this.responseMessage,
    this.cardTokenRef,
    this.cardId,
    this.fullCardNumber,
    this.maskedPan,
    this.expiryDate,
    this.cvv,
    this.nameOnCard,
    this.cardType,
    this.cardLogo,
    this.cardStatus,
    this.cardControls,
    this.limits,
    this.product,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) => CardDetails(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        cardTokenRef: json["cardTokenRef"],
        cardId: json["cardId"],
        fullCardNumber: json["fullCardNumber"],
        maskedPan: json["maskedPan"],
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        cvv: json["cvv"],
        nameOnCard: json["nameOnCard"],
        cardType: json["cardType"],
        cardLogo: json["cardLogo"],
        cardStatus: (json["cardStatus"] as String?).jsonCardStatus,
        cardControls: json["cardControls"] == null
            ? []
            : (json["cardControls"] as List)
                .map((e) => CardControl.fromJson(e))
                .toList(),
        limits: json["limits"] == null
            ? []
            : (json["limits"] as List).map((e) => Limit.fromJson(e)).toList(),
    product: json['product'] == null ? null : ProductsInfo.fromJson(json['product']),
      );
}

class CardControl {
  final ControlTypes? controlType;
  final String? description;
  final String? value;

  CardControl({
    this.controlType,
    this.description,
    this.value,
  });

  factory CardControl.fromJson(Map<String, dynamic> json) => CardControl(
        controlType: (json["controlType"] as String?).controlTypes,
        description: json["description"],
        value: json["value"],
      );
}

class Limit {
  final LimitTypes? limitType;
  final String? maxLimit;

  Limit({
    this.limitType,
    this.maxLimit,
  });

  factory Limit.fromJson(Map<String, dynamic> json) => Limit(
        limitType: (json["limitType"] as String?).limitTypes,
        maxLimit: json["maxLimit"],
      );
}

class ProductsInfo {
  final String? responseCode;
  final String? responseMessage;
  final int? id;
  final String? productCode;
  final String? productName;
  final String? currencyCode;
  final CardSchemaType? schemeType;
  final CardType? cardType;
  final String? cardCategory;
  final String? minLimit;
  final String? maxLimit;
  final String? dailyLimit;
  final String? posLimit;
  final String? webLimit;
  final String? atmLimit;
  final String? atmAllowed;
  final String? posAllowed;
  final String? webAllowed;
  final String? contactlessAllowed;
  final String? crossBorderAllowed;
  final CardStatus? status;
  final String? cardImage;

  ProductsInfo({
    this.responseCode,
    this.responseMessage,
    this.id,
    this.productCode,
    this.productName,
    this.currencyCode,
    this.schemeType,
    this.cardType,
    this.cardCategory,
    this.minLimit,
    this.maxLimit,
    this.dailyLimit,
    this.posLimit,
    this.webLimit,
    this.atmLimit,
    this.atmAllowed,
    this.posAllowed,
    this.webAllowed,
    this.contactlessAllowed,
    this.crossBorderAllowed,
    this.status,
    this.cardImage,
  });

  factory ProductsInfo.fromJson(Map<String, dynamic> json) => ProductsInfo(
    responseCode: json["responseCode"] ?? '',
    responseMessage: json["responseMessage"] ?? '',
    id: json["id"],
    productCode: json["productCode"] ?? '',
    productName: json["productName"] ?? '',
    currencyCode: json["currencyCode"] ?? '',
    schemeType: (json["schemeType"] as String?).jsonCardSchemaType,
    cardType: (json["cardType"] as String?).jsonCardMethod,
    cardCategory: json["cardCategory"] ?? '',
    minLimit: json["minLimit"] ?? '',
    maxLimit: json["maxLimit"] ?? '',
    dailyLimit: json["dailyLimit"] ?? '',
    posLimit: json["posLimit"] ?? '',
    webLimit: json["webLimit"] ?? '',
    atmLimit: json["atmLimit"] ?? '',
    atmAllowed: json["atmAllowed"] ?? '',
    posAllowed: json["posAllowed"] ?? '',
    webAllowed: json["webAllowed"] ?? '',
    contactlessAllowed: json["contactlessAllowed"] ?? '',
    crossBorderAllowed: json["crossBorderAllowed"] ?? '',
    status: (json["status"] as String?).jsonCardStatus,
    cardImage: json["cardImage"] ?? '',
  );
}

