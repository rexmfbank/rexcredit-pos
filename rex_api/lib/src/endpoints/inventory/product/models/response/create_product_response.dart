import 'dart:convert';

class CreateProductResponse {
  String responseCode;
  String responseMessage;
  CreateProductResponseData? data;

  CreateProductResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  CreateProductResponse copyWith({
    String? responseCode,
    String? responseMessage,
    CreateProductResponseData? data,
  }) =>
      CreateProductResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory CreateProductResponse.fromRawJson(String str) => CreateProductResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateProductResponse.fromJson(Map<String, dynamic> json) => CreateProductResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : CreateProductResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };
}

class CreateProductResponseData {
  int? id;
  String? entityCode;
  String? merchantCode;
  String? storeCode;
  String? categoryCode;
  String? productCode;
  String? name;
  String? subTitle;
  String? unit;
  double? costPrice;
  double? salePrice;
  int? discount;
  int? stockQuantity;
  bool? stockTrackingEnabled;
  String? actionOnLowStock;
  int? reorderLevel;
  String? status;
  List<String>? imageUrls;
  bool? canExpire;
  String? barcode;
  bool? isDeleted;
  String? description;
  String? modifiedDate;

  CreateProductResponseData({
    this.id,
    this.entityCode,
    this.merchantCode,
    this.storeCode,
    this.categoryCode,
    this.productCode,
    this.name,
    this.subTitle,
    this.unit,
    this.costPrice,
    this.salePrice,
    this.discount,
    this.stockQuantity,
    this.stockTrackingEnabled,
    this.actionOnLowStock,
    this.reorderLevel,
    this.status,
    this.imageUrls,
    this.canExpire,
    this.barcode,
    this.isDeleted,
    this.description,
    this.modifiedDate,
  });

  CreateProductResponseData copyWith({
    int? id,
    String? entityCode,
    String? merchantCode,
    String? storeCode,
    String? categoryCode,
    String? productCode,
    String? name,
    String? subTitle,
    String? unit,
    double? costPrice,
    double? salePrice,
    int? discount,
    int? stockQuantity,
    bool? stockTrackingEnabled,
    String? actionOnLowStock,
    int? reorderLevel,
    String? status,
    List<String>? imageUrls,
    bool? canExpire,
    String? barcode,
    bool? isDeleted,
    String? description,
    String? modifiedDate,
  }) =>
      CreateProductResponseData(
        id: id ?? this.id,
        entityCode: entityCode ?? this.entityCode,
        merchantCode: merchantCode ?? this.merchantCode,
        storeCode: storeCode ?? this.storeCode,
        categoryCode: categoryCode ?? this.categoryCode,
        productCode: productCode ?? this.productCode,
        name: name ?? this.name,
        subTitle: subTitle ?? this.subTitle,
        unit: unit ?? this.unit,
        costPrice: costPrice ?? this.costPrice,
        salePrice: salePrice ?? this.salePrice,
        discount: discount ?? this.discount,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        stockTrackingEnabled: stockTrackingEnabled ?? this.stockTrackingEnabled,
        actionOnLowStock: actionOnLowStock ?? this.actionOnLowStock,
        reorderLevel: reorderLevel ?? this.reorderLevel,
        status: status ?? this.status,
        imageUrls: imageUrls ?? this.imageUrls,
        canExpire: canExpire ?? this.canExpire,
        barcode: barcode ?? this.barcode,
        isDeleted: isDeleted ?? this.isDeleted,
        description: description ?? this.description,
        modifiedDate: modifiedDate ?? this.modifiedDate,
      );

  factory CreateProductResponseData.fromRawJson(String str) => CreateProductResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateProductResponseData.fromJson(Map<String, dynamic> json) => CreateProductResponseData(
    id: json["id"],
    entityCode: json["entityCode"] ?? '',
    merchantCode: json["merchantCode"] ?? '',
    storeCode: json["storeCode"] ?? '',
    categoryCode: json["categoryCode"] ?? '',
    productCode: json["productCode"] ?? '',
    name: json["name"] ?? '',
    subTitle: json["subTitle"] ?? '',
    unit: json["unit"] ?? '',
    costPrice: json["costPrice"],
    salePrice: json["salePrice"],
    discount: json["discount"],
    stockQuantity: json["stockQuantity"],
    stockTrackingEnabled: json["stockTrackingEnabled"],
    actionOnLowStock: json["actionOnLowStock"],
    reorderLevel: json["reorderLevel"],
    status: json["status"] ?? '',
    imageUrls: json["imageUrls"] == null ? [] : List<String>.from(json["imageUrls"]!.map((x) => x)),
    canExpire: json["canExpire"],
    barcode: json["barcode"] ?? '',
    isDeleted: json["isDeleted"],
    description: json["description"] ?? '',
    modifiedDate: json["modifiedDate"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entityCode": entityCode,
    "merchantCode": merchantCode,
    "storeCode": storeCode,
    "categoryCode": categoryCode,
    "productCode": productCode,
    "name": name,
    "subTitle": subTitle,
    "unit": unit,
    "costPrice": costPrice,
    "salePrice": salePrice,
    "discount": discount,
    "stockQuantity": stockQuantity,
    "stockTrackingEnabled": stockTrackingEnabled,
    "actionOnLowStock": actionOnLowStock,
    "reorderLevel": reorderLevel,
    "status": status,
    "imageUrls": imageUrls == null ? [] : List<dynamic>.from(imageUrls!.map((x) => x)),
    "canExpire": canExpire,
    "barcode": barcode,
    "isDeleted": isDeleted,
    "description": description,
  };
}

