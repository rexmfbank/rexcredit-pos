import 'package:rex_api/src/endpoints/inventory/shop/models/response/shop_data.dart';

class GetStoresResponse {
  final String responseCode;
  final String responseMessage;
  final List<ShopDataModel>? data;

  GetStoresResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory GetStoresResponse.fromJson(Map<String, dynamic> json) => GetStoresResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data:json["data"] == null ? [] : (json["data"] as List).map((e) => ShopDataModel.fromJson(e)).toList(),
  );
}
