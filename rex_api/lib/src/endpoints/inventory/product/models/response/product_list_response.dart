import 'dart:convert';

class ProductListResponse {
  String responseCode;
  String responseMessage;
  List<ProductListResponseData>? data;

  ProductListResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  ProductListResponse copyWith({
    String? responseCode,
    String? responseMessage,
    List<ProductListResponseData>? data,
  }) =>
      ProductListResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory ProductListResponse.fromRawJson(String str) => ProductListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => ProductListResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? [] : List<ProductListResponseData>.from(json["data"]!.map((x) => ProductListResponseData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProductListResponseData {
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
  double? discount;
  String? discountRef;
  int? stockQuantity;
  bool? stockTrackingEnabled;
  String? actionOnLowStock;
  int? minimumStock;
  int? reorderLevel;
  List<String>? imageUrls;
  bool? canExpire;
  String? barcode;
  String? brand;
  String? model;
  String? unitFormula;
  bool? isDeleted;
  String? productSize;
  String? productModel;
  int? productYear;
  String? productTag;
  String? description;
  String? createdDate;

  ProductListResponseData({
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
    this.discountRef,
    this.stockQuantity,
    this.stockTrackingEnabled,
    this.actionOnLowStock,
    this.minimumStock,
    this.reorderLevel,
    this.imageUrls,
    this.canExpire,
    this.barcode,
    this.brand,
    this.model,
    this.unitFormula,
    this.isDeleted,
    this.productSize,
    this.productModel,
    this.productYear,
    this.productTag,
    this.description,
    this.createdDate,
  });

  ProductListResponseData copyWith({
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
    double? discount,
    String? discountRef,
    int? stockQuantity,
    bool? stockTrackingEnabled,
    String? actionOnLowStock,
    int? minimumStock,
    int? reorderLevel,
    List<String>? imageUrls,
    bool? canExpire,
    String? barcode,
    String? brand,
    String? model,
    String? unitFormula,
    bool? isDeleted,
    String? productSize,
    String? productModel,
    int? productYear,
    String? productTag,
    String? description,
    String? createdDate,
  }) =>
      ProductListResponseData(
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
        discountRef: discountRef ?? this.discountRef,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        stockTrackingEnabled: stockTrackingEnabled ?? this.stockTrackingEnabled,
        actionOnLowStock: actionOnLowStock ?? this.actionOnLowStock,
        minimumStock: minimumStock ?? this.minimumStock,
        reorderLevel: reorderLevel ?? this.reorderLevel,
        imageUrls: imageUrls ?? this.imageUrls,
        canExpire: canExpire ?? this.canExpire,
        barcode: barcode ?? this.barcode,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        unitFormula: unitFormula ?? this.unitFormula,
        isDeleted: isDeleted ?? this.isDeleted,
        productSize: productSize ?? this.productSize,
        productModel: productModel ?? this.productModel,
        productYear: productYear ?? this.productYear,
        productTag: productTag ?? this.productTag,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
      );

  factory ProductListResponseData.fromRawJson(String str) => ProductListResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductListResponseData.fromJson(Map<String, dynamic> json) => ProductListResponseData(
    id: json["id"],
    entityCode: json["entityCode"],
    merchantCode: json["merchantCode"],
    storeCode: json["storeCode"],
    categoryCode: json["categoryCode"],
    productCode: json["productCode"],
    name: json["name"],
    subTitle: json["subTitle"],
    unit: json["unit"],
    costPrice: json["costPrice"],
    salePrice: json["salePrice"],
    discount: json["discount"],
    discountRef: json["discountRef"],
    stockQuantity: json["stockQuantity"],
    stockTrackingEnabled: json["stockTrackingEnabled"],
    actionOnLowStock: json["actionOnLowStock"],
    minimumStock: json["minimumStock"],
    reorderLevel: json["reorderLevel"],
    imageUrls: json["imageUrls"] == null ? [] : List<String>.from(json["imageUrls"]!.map((x) => x)),
    canExpire: json["canExpire"],
    barcode: json["barcode"],
    brand: json["brand"],
    model: json["model"],
    unitFormula: json["unitFormula"],
    isDeleted: json["isDeleted"],
    productSize: json["productSize"],
    productModel: json["productModel"],
    productYear: json["productYear"],
    productTag: json["productTag"],
    description: json["description"],
    createdDate: json["createdDate"],
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
    "discountRef": discountRef,
    "stockQuantity": stockQuantity,
    "stockTrackingEnabled": stockTrackingEnabled,
    "actionOnLowStock": actionOnLowStock,
    "minimumStock": minimumStock,
    "reorderLevel": reorderLevel,
    "imageUrls": imageUrls == null ? [] : List<dynamic>.from(imageUrls!.map((x) => x)),
    "canExpire": canExpire,
    "barcode": barcode,
    "brand": brand,
    "model": model,
    "unitFormula": unitFormula,
    "isDeleted": isDeleted,
    "productSize": productSize,
    "productModel": productModel,
    "productYear": productYear,
    "productTag": productTag,
    "description": description,
    "createdDate": createdDate,
  };
}
