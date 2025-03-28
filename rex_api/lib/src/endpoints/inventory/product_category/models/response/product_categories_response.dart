
import 'package:rex_api/src/utils/enums/category_status.dart';

class ProductCategoriesResponse {
  String responseCode;
  String responseMessage;
  List<ProductCategoriesResponseData>? data;

  ProductCategoriesResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  ProductCategoriesResponse copyWith({
    String? responseCode,
    String? responseMessage,
    List<ProductCategoriesResponseData>? data,
  }) =>
      ProductCategoriesResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory ProductCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      ProductCategoriesResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? []
            : List<ProductCategoriesResponseData>.from(json["data"]!
                .map((x) => ProductCategoriesResponseData.fromJson(x))),
      );
}

class ProductCategoriesResponseData {
  String? createdDate;
  String? createdBy;
  String? modifiedBy;
  String? modifiedDate;
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
  CategoryStatus? status;

  ProductCategoriesResponseData({
    this.createdDate,
    this.createdBy,
    this.modifiedBy,
    this.modifiedDate,
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
    this.status,
  });

  ProductCategoriesResponseData copyWith({
    String? createdDate,
    String? createdBy,
    String? modifiedBy,
    String? modifiedDate,
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
    CategoryStatus? status,
  }) =>
      ProductCategoriesResponseData(
        createdDate: createdDate ?? this.createdDate,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        modifiedDate: modifiedDate ?? this.modifiedDate,
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
        status: status ?? this.status,
      );

  factory ProductCategoriesResponseData.fromJson(Map<String, dynamic> json) =>
      ProductCategoriesResponseData(
        createdDate: json["createdDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
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
        status: (json["status"] as String?).jsonCategoryStatus,
      );
}
