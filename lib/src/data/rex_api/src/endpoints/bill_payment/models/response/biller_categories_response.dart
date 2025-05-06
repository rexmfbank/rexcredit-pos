import 'dart:convert';

class BillerCategoriesResponse {
  String responseCode;
  String responseMessage;
  BillerCategoriesResponseData data;

  BillerCategoriesResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory BillerCategoriesResponse.fromRawJson(String str) =>
      BillerCategoriesResponse.fromJson(json.decode(str));

  factory BillerCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      BillerCategoriesResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: BillerCategoriesResponseData.fromJson(json['data']),
      );
}

class BillerCategoriesResponseData {
  List<BillerCategory>? category;

  BillerCategoriesResponseData({
    this.category,
  });

  BillerCategoriesResponseData copyWith({
    List<BillerCategory>? category,
  }) =>
      BillerCategoriesResponseData(
        category: category ?? this.category,
      );

  factory BillerCategoriesResponseData.fromRawJson(String str) =>
      BillerCategoriesResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillerCategoriesResponseData.fromJson(Map<String, dynamic> json) =>
      BillerCategoriesResponseData(
        category: json["category"] == null
            ? []
            : List<BillerCategory>.from(
                json["category"]!.map((x) => BillerCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class BillerCategory {
  int? id;
  String? billerCategoryCode;
  String? billerCategoryName;
  String? billerCategoryDescription;
  String? logoUrl;
  String? countryCode;
  String? status;

  BillerCategory({
    this.id,
    this.billerCategoryCode,
    this.billerCategoryName,
    this.billerCategoryDescription,
    this.logoUrl,
    this.countryCode,
    this.status,
  });

  BillerCategory copyWith({
    int? id,
    String? billerCategoryCode,
    String? billerCategoryName,
    String? billerCategoryDescription,
    String? logoUrl,
    String? countryCode,
    String? status,
  }) =>
      BillerCategory(
        id: id ?? this.id,
        billerCategoryCode: billerCategoryCode ?? this.billerCategoryCode,
        billerCategoryName: billerCategoryName ?? this.billerCategoryName,
        billerCategoryDescription:
            billerCategoryDescription ?? this.billerCategoryDescription,
        logoUrl: logoUrl ?? this.logoUrl,
        countryCode: countryCode ?? this.countryCode,
        status: status ?? this.status,
      );

  factory BillerCategory.fromRawJson(String str) =>
      BillerCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillerCategory.fromJson(Map<String, dynamic> json) => BillerCategory(
        id: json["id"],
        billerCategoryCode: json["billerCategoryCode"],
        billerCategoryName: json["billerCategoryName"],
        billerCategoryDescription: json["billerCategoryDescription"],
        logoUrl: json["logoURL"],
        countryCode: json["countryCode"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "billerCategoryCode": billerCategoryCode,
        "billerCategoryName": billerCategoryName,
        "billerCategoryDescription": billerCategoryDescription,
        "logoURL": logoUrl,
        "countryCode": countryCode,
        "status": status,
      };
}
