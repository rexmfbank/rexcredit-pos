import '../response/staff_model.dart';

class ShopRequest {
  final String? code;
  final String name;
  final String? storeType;
  final String contactPhone;
  final String? contactEmail;
  final String? managerUsername;
  final String? merchantCode;
  final String address;
  final String? description;
  final List<StaffModel>? staffDetails;

  ShopRequest({
    required this.name,
    required this.contactPhone,
    required this.address,
    this.code,
    this.storeType,
    this.contactEmail,
    this.managerUsername,
    this.merchantCode,
    this.description,
    this.staffDetails,
  });

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "storeType": storeType,
        "contactPhone": contactPhone,
        "contactEmail": contactEmail,
        "managerUsername": managerUsername,
        "merchantCode": merchantCode,
        "address": address,
        "description": description,
        "staff": staffDetails == null
            ? []
            : List<StaffModel>.from(staffDetails!.map((x) => x)).toList(),
      };
}
