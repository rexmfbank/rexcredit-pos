import 'package:rex_api/src/endpoints/inventory/shop/models/response/staff_model.dart';

class ShopData{
  final String responseCode;
  final String responseMessage;
  final ShopDataModel? data;

  ShopData({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) => ShopData(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : ShopDataModel.fromJson(json["data"]),
  );
}

class ShopDataModel {
  final String? createdDate;
  final int? id;
  final String? code;
  final String? name;
  final String? storeType;
  final String? contactPhone;
  final String? contactEmail;
  final String? managerUsername;
  final String? merchantCode;
  final String? entityCode;
  final String? status;
  final bool? isDeleted;
  final String? address;
  final String? description;
  final List<StaffModel>? staff;

  ShopDataModel({
    this.createdDate,
    this.id,
    this.code,
    this.name,
    this.storeType,
    this.contactPhone,
    this.contactEmail,
    this.managerUsername,
    this.merchantCode,
    this.entityCode,
    this.status,
    this.isDeleted,
    this.address,
    this.description,
    this.staff,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) => ShopDataModel(
    createdDate: json["createdDate"],
    id: json["id"],
    code: json["code"],
    name: json["name"],
    storeType: json["storeType"],
    contactPhone: json["contactPhone"],
    contactEmail: json["contactEmail"],
    managerUsername: json["managerUsername"],
    merchantCode: json["merchantCode"],
    entityCode: json["entityCode"],
    status: json["status"],
    isDeleted: json["isDeleted"],
    address: json["address"],
    description: json["description"],
    staff:json["staff"] == null ? [] : (json["staff"] as List).map((e) => StaffModel.fromJson(e)).toList(),
  );
}