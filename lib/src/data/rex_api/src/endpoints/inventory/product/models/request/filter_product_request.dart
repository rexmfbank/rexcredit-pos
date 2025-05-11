import 'dart:convert';

class FilterProductRequest {
  String? merchantCode;
  String? categoryCode;
  String? productCode;
  String? storeCode;
  String? barcode;
  String? name;
  String? startDate;
  String? endDate;
  int pageIndex;
  int pageSize;

  FilterProductRequest({
    this.merchantCode,
    this.categoryCode,
    this.productCode,
    this.storeCode,
    this.barcode,
    this.name,
    this.startDate,
    this.endDate,
    required this.pageIndex,
    required this.pageSize,
  });

  FilterProductRequest copyWith({
    String? merchantCode,
    String? categoryCode,
    String? productCode,
    String? storeCode,
    String? barcode,
    String? name,
    String? startDate,
    String? endDate,
    int? pageIndex,
    int? pageSize,
  }) =>
      FilterProductRequest(
        merchantCode: merchantCode ?? this.merchantCode,
        categoryCode: categoryCode ?? this.categoryCode,
        productCode: productCode ?? this.productCode,
        storeCode: storeCode ?? this.storeCode,
        barcode: barcode ?? this.barcode,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
      );

  factory FilterProductRequest.fromRawJson(String str) => FilterProductRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterProductRequest.fromJson(Map<String, dynamic> json) => FilterProductRequest(
    merchantCode: json["merchantCode"],
    categoryCode: json["categoryCode"],
    productCode: json["productCode"],
    storeCode: json["storeCode"],
    barcode: json["barcode"],
    name: json["name"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    pageIndex: json["pageIndex"],
    pageSize: json["pageSize"],
  );

  Map<String, dynamic> toJson() => {
    "merchantCode": merchantCode,
    "categoryCode": categoryCode,
    "productCode": productCode,
    "storeCode": storeCode,
    "barcode": barcode,
    "name": name,
    "startDate": startDate,
    "endDate": endDate,
    "pageIndex": pageIndex,
    "pageSize": pageSize,
  };
}
