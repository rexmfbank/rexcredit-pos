import 'dart:convert';

class CreateProductCategoryRequest {
  String name;
  String categoryCode;
  String categoryType;
  String? sector;
  String? logoUrl;
  String merchantCode;
  String description;
  String status;

  CreateProductCategoryRequest({
    required this.name,
    required this.categoryCode,
    required this.categoryType,
    this.sector,
    this.logoUrl = 'https://picsum.photos/200',
    required this.merchantCode,
    required this.description,
    required this.status
  });

  CreateProductCategoryRequest copyWith({
    String? name,
    String? categoryCode,
    String? categoryType,
    String? sector,
    String? logoUrl,
    String? merchantCode,
    String? description,
    String? status
  }) =>
      CreateProductCategoryRequest(
        name: name ?? this.name,
        categoryCode: categoryCode ?? this.categoryCode,
        categoryType: categoryType ?? this.categoryType,
        sector: sector ?? this.sector,
        logoUrl: logoUrl ?? this.logoUrl,
        merchantCode: merchantCode ?? this.merchantCode,
        description: description ?? this.description,
        status: status ?? this.status
      );

  factory CreateProductCategoryRequest.fromRawJson(String str) => CreateProductCategoryRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateProductCategoryRequest.fromJson(Map<String, dynamic> json) => CreateProductCategoryRequest(
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
