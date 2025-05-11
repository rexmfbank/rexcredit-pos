import 'dart:convert';

class CreateProductCategoryResponse {
  String responseCode;
  String responseMessage;
  ProductCategoryResponseData? data;

  CreateProductCategoryResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  CreateProductCategoryResponse copyWith({
    String? responseCode,
    String? responseMessage,
    ProductCategoryResponseData? data,
  }) =>
      CreateProductCategoryResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory CreateProductCategoryResponse.fromRawJson(String str) => CreateProductCategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateProductCategoryResponse.fromJson(Map<String, dynamic> json) => CreateProductCategoryResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : ProductCategoryResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };
}

class ProductCategoryResponseData {
  DateTime? createdDate;
  String? createdBy;
  int? id;
  String? name;
  String? categoryCode;
  String? categoryType;
  String? sector;
  String? logoUrl;
  String? merchantCode;
  String? entityCode;
  bool? isDeleted;
  String? description;

  ProductCategoryResponseData({
    this.createdDate,
    this.createdBy,
    this.id,
    this.name,
    this.categoryCode,
    this.categoryType,
    this.sector,
    this.logoUrl,
    this.merchantCode,
    this.entityCode,
    this.isDeleted,
    this.description,
  });

  ProductCategoryResponseData copyWith({
    DateTime? createdDate,
    String? createdBy,
    String? modifiedBy,
    DateTime? modifiedDate,
    int? id,
    String? name,
    String? categoryCode,
    String? categoryType,
    String? sector,
    String? logoUrl,
    String? merchantCode,
    String? entityCode,
    bool? isDeleted,
    String? description,
  }) =>
      ProductCategoryResponseData(
        createdDate: createdDate ?? this.createdDate,
        createdBy: createdBy ?? this.createdBy,
        id: id ?? this.id,
        name: name ?? this.name,
        categoryCode: categoryCode ?? this.categoryCode,
        categoryType: categoryType ?? this.categoryType,
        sector: sector ?? this.sector,
        logoUrl: logoUrl ?? this.logoUrl,
        merchantCode: merchantCode ?? this.merchantCode,
        entityCode: entityCode ?? this.entityCode,
        isDeleted: isDeleted ?? this.isDeleted,
        description: description ?? this.description,
      );

  factory ProductCategoryResponseData.fromRawJson(String str) => ProductCategoryResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategoryResponseData.fromJson(Map<String, dynamic> json) => ProductCategoryResponseData(
    createdDate: json["createdDate"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["createdDate"]),
    createdBy: json["createdBy"],
    id: json["id"],
    name: json["name"],
    categoryCode: json["categoryCode"],
    categoryType: json["categoryType"],
    sector: json["sector"],
    logoUrl: json["logoUrl"],
    merchantCode: json["merchantCode"],
    entityCode: json["entityCode"],
    isDeleted: json["isDeleted"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "createdDate": createdDate?.millisecondsSinceEpoch,
    "createdBy": createdBy,
    "id": id,
    "name": name,
    "categoryCode": categoryCode,
    "categoryType": categoryType,
    "sector": sector,
    "logoUrl": logoUrl,
    "merchantCode": merchantCode,
    "entityCode": entityCode,
    "isDeleted": isDeleted,
    "description": description,
  };
}
