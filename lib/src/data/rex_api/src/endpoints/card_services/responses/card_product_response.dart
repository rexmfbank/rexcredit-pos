import '../../../utils/enums/card_schema_type.dart';
import '../../../utils/enums/card_status.dart';
import '../../../utils/enums/card_type.dart';

class CardProductsResponse {
  final String? responseCode;
  final String? responseMessage;
  final String? entityCode;
  final List<CardProducts>? data;

  CardProductsResponse({
    this.responseCode,
    this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory CardProductsResponse.fromJson(Map<String, dynamic> json) =>
      CardProductsResponse(
        responseCode: json["responseCode"] ?? '',
        responseMessage: json["responseMessage"] ?? '',
        entityCode: json["entityCode"] ?? '',
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => CardProducts.fromJson(e))
                .toList(),
      );
}

class CardProducts {
  final int? id;
  final String? productCode;
  final String? productName;
  final String? currencyCode;
  final CardSchemaType? schemeType;
  final CardType? cardType;
  final String? cardCategory;
  final double? minLimit;
  final double? maxLimit;
  final double? dailyLimit;
  final double? posLimit;
  final double? webLimit;
  final double? atmLimit;
  final String? atmAllowed;
  final String? posAllowed;
  final String? webAllowed;
  final String? contactlessAllowed;
  final String? crossBorderAllowed;
  final CardStatus? status;
  final bool? abroadEnabled;
  final double? contactlessLimit;

  CardProducts({
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
    this.abroadEnabled,
    this.contactlessLimit,
  });

  factory CardProducts.fromJson(Map<String, dynamic> json) => CardProducts(
        id: json["id"],
        productCode: json["productCode"] ?? '',
        productName: json["productName"] ?? '',
        currencyCode: json["currencyCode"] ?? '',
        schemeType: (json["schemeType"] as String?).jsonCardSchemaType,
        cardType: (json["cardType"] as String?).jsonCardMethod,
        cardCategory: json["cardCategory"] ?? '',
        minLimit: (json["minLimit"] ?? 0).toDouble(),
        maxLimit: (json["maxLimit"] ?? 0).toDouble(),
        dailyLimit: (json["dailyLimit"] ?? 0).toDouble(),
        posLimit: (json["posLimit"] ?? 0).toDouble(),
        webLimit: (json["webLimit"] ?? 0).toDouble(),
        atmLimit: (json["atmLimit"] ?? 0).toDouble(),
        atmAllowed: json["atmAllowed"] ?? '',
        posAllowed: json["posAllowed"] ?? '',
        webAllowed: json["webAllowed"] ?? '',
        contactlessAllowed: json["contactlessAllowed"],
        crossBorderAllowed: json["crossBorderAllowed"],
        status: (json["status"] as String?).jsonCardStatus,
        abroadEnabled: json["abroadEnabled"] ?? false,
        contactlessLimit: json["contactlessLimit"],
      );
}
