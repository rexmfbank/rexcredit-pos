import 'dart:convert';

class SearchProductCategoryResponse {
  String responseCode;
  String responseMessage;
  List<Datum>? data;

  SearchProductCategoryResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  SearchProductCategoryResponse copyWith({
    String? responseCode,
    String? responseMessage,
    List<Datum>? data,
  }) =>
      SearchProductCategoryResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory SearchProductCategoryResponse.fromRawJson(String str) => SearchProductCategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchProductCategoryResponse.fromJson(Map<String, dynamic> json) => SearchProductCategoryResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  DateTime? createdDate;
  String? createdBy;
  String? modifiedBy;
  DateTime? modifiedDate;
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

  Datum({
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
  });

  Datum copyWith({
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
      Datum(
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
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
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
    "createdDate": createdDate?.toIso8601String(),
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "modifiedDate": modifiedDate?.toIso8601String(),
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
