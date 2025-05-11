import 'dart:convert';

class CreateProductRequest {
  String merchantCode;
  String storeCode;
  String categoryCode;
  String productCode;
  String name;
  String? subTitle;
  String unit;
  num costPrice;
  num salePrice;
  num? discount;
  String? discountRef;
  int stockQuantity;
  bool stockTrackingEnabled;
  String actionOnLowStock;
  int? minimumStock;
  int reorderLevel;
  List<String> imageUrls;
  bool canExpire;
  String? barcode;
  String? brand;
  String? model;
  String? unitFormula;
  String? productSize;
  String? productModel;
  int? productYear;
  String? productTag;
  String description;

  CreateProductRequest({
    required this.merchantCode,
    required this.storeCode,
    required this.categoryCode,
    required this.productCode,
    required this.name,
    this.subTitle,
    required this.unit,
    required this.costPrice,
    required this.salePrice,
    this.discount = 0.00,
    this.discountRef,
    required this.stockQuantity,
    required this.stockTrackingEnabled,
    required this.actionOnLowStock,
    this.minimumStock,
    required this.reorderLevel,
    required this.imageUrls,
    required this.canExpire,
    this.barcode,
    this.brand,
    this.model,
    this.unitFormula,
    this.productSize,
    this.productModel,
    this.productYear,
    this.productTag,
    required this.description,
  });



  factory CreateProductRequest.fromRawJson(String str) => CreateProductRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) => CreateProductRequest(
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
    imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
    canExpire: json["canExpire"],
    barcode: json["barcode"],
    brand: json["brand"],
    model: json["model"],
    unitFormula: json["unitFormula"],
    productSize: json["productSize"],
    productModel: json["productModel"],
    productYear: json["productYear"],
    productTag: json["productTag"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
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
    "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
    "canExpire": canExpire,
    "barcode": barcode,
    "brand": brand,
    "model": model,
    "unitFormula": unitFormula,
    "productSize": productSize,
    "productModel": productModel,
    "productYear": productYear,
    "productTag": productTag,
    "description": description,
  };

  CreateProductRequest copyWith({
    String? merchantCode,
    String? storeCode,
    String? categoryCode,
    String? productCode,
    String? name,
    String? subTitle,
    String? unit,
    num? costPrice,
    num? salePrice,
    num? discount,
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
    String? productSize,
    String? productModel,
    int? productYear,
    String? productTag,
    String? description,
  }) {
    return CreateProductRequest(
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
      productSize: productSize ?? this.productSize,
      productModel: productModel ?? this.productModel,
      productYear: productYear ?? this.productYear,
      productTag: productTag ?? this.productTag,
      description: description ?? this.description,
    );
  }
}
