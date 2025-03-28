import 'dart:convert';

class UpdateProductCategoryRequest {
  String name;
  String categoryCode;
  String categoryType;
  String? sector;
  String? logoUrl;
  String merchantCode;
  String description;
  String status;

  UpdateProductCategoryRequest({
    required this.name,
    required this.categoryCode,
    required this.categoryType,
    this.sector,
    this.logoUrl,
    required this.merchantCode,
    required this.description,
    required this.status,
  });

  UpdateProductCategoryRequest copyWith({
    String? name,
    String? categoryCode,
    String? categoryType,
    String? sector,
    String? logoUrl,
    String? merchantCode,
    String? description,
    String? status,
  }) =>
      UpdateProductCategoryRequest(
        name: name ?? this.name,
        categoryCode: categoryCode ?? this.categoryCode,
        categoryType: categoryType ?? this.categoryType,
        sector: sector ?? this.sector,
        logoUrl: logoUrl ?? this.logoUrl,
        merchantCode: merchantCode ?? this.merchantCode,
        description: description ?? this.description,
        status: status ?? this.status,
      );

  factory UpdateProductCategoryRequest.fromRawJson(String str) => UpdateProductCategoryRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProductCategoryRequest.fromJson(Map<String, dynamic> json) => UpdateProductCategoryRequest(
    name: json["name"],
    categoryCode: json["categoryCode"],
    categoryType: json["categoryType"],
    sector: json["sector"],
    logoUrl: json["logoUrl"],
    merchantCode: json["merchantCode"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "categoryCode": categoryCode,
    "categoryType": categoryType,
    "sector": sector,
    "logoUrl": logoUrl,
    "merchantCode": merchantCode,
    "description": description,
    "status": status,
  };
}
