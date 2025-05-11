import 'dart:convert';

import 'product_list_response.dart';

class FilterProductResponse {
  String responseCode;
  String responseMessage;
  List<ProductListResponseData>? data;
  int? pageIndex;
  int? pageSize;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPreviousPage;
  int? totalContent;

  FilterProductResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
    this.pageIndex,
    this.pageSize,
    this.totalPages,
    this.hasNextPage,
    this.hasPreviousPage,
    this.totalContent,
  });

  FilterProductResponse copyWith({
    String? responseCode,
    String? responseMessage,
    List<ProductListResponseData>? data,
    int? pageIndex,
    int? pageSize,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPreviousPage,
    int? totalContent,
  }) =>
      FilterProductResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
        totalPages: totalPages ?? this.totalPages,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
        totalContent: totalContent ?? this.totalContent,
      );

  factory FilterProductResponse.fromRawJson(String str) => FilterProductResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterProductResponse.fromJson(Map<String, dynamic> json) => FilterProductResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? [] : List<ProductListResponseData>.from(json["data"]!.map((x) => ProductListResponseData.fromJson(x))),
    pageIndex: json["pageIndex"],
    pageSize: json["pageSize"],
    totalPages: json["totalPages"],
    hasNextPage: json["hasNextPage"],
    hasPreviousPage: json["hasPreviousPage"],
    totalContent: json["totalContent"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pageIndex": pageIndex,
    "pageSize": pageSize,
    "totalPages": totalPages,
    "hasNextPage": hasNextPage,
    "hasPreviousPage": hasPreviousPage,
    "totalContent": totalContent,
  };
}

class FilterProductResponseData {
  DateTime? createdDate;
  String? createdBy;
  String? modifiedBy;
  DateTime? modifiedDate;
  int? id;
  String? entityCode;
  String? merchantCode;
  String? storeCode;
  String? categoryCode;
  String? productCode;
  String? name;
  String? subTitle;
  String? unit;
  num? costPrice;
  num? salePrice;
  num? discount;
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

  FilterProductResponseData({
    this.createdDate,
    this.createdBy,
    this.modifiedBy,
    this.modifiedDate,
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
  });

  FilterProductResponseData copyWith({
    DateTime? createdDate,
    String? createdBy,
    String? modifiedBy,
    DateTime? modifiedDate,
    int? id,
    String? entityCode,
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
    bool? isDeleted,
    String? productSize,
    String? productModel,
    int? productYear,
    String? productTag,
    String? description,
  }) =>
      FilterProductResponseData(
        createdDate: createdDate ?? this.createdDate,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        modifiedDate: modifiedDate ?? this.modifiedDate,
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
      );

  factory FilterProductResponseData.fromRawJson(String str) => FilterProductResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterProductResponseData.fromJson(Map<String, dynamic> json) => FilterProductResponseData(
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
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
  );

  Map<String, dynamic> toJson() => {
    "createdDate": createdDate?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "modifiedDate": modifiedDate?.toIso8601String(),
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
  };
}
