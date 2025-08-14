import 'package:equatable/equatable.dart';

class UtilityType extends Equatable {
  final int id;
  final String type;
  final String name;
  final String code;
  final String chargeType;
  final String serviceFee;
  final String? logo;
  final String createdAt;

  const UtilityType({
    required this.id,
    required this.type,
    required this.name,
    required this.code,
    required this.chargeType,
    required this.serviceFee,
    required this.logo,
    required this.createdAt,
  });

  const UtilityType.empty()
      : id = 0,
        type = '',
        name = '',
        code = '',
        chargeType = '',
        serviceFee = '',
        logo = '',
        createdAt = '';

  factory UtilityType.fromJson(Map<String, dynamic> json) {
    return UtilityType(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      code: json['code'],
      chargeType: json['charge_type'],
      serviceFee: json['service_fee'],
      logo: json['logo'],
      createdAt: json['created_at'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "UtilityType",
      "id": id,
      "type": type,
      "name": name,
      "code": code,
      "chargeType": chargeType,
      "serviceFee": serviceFee,
      "logo": logo,
      "createdAt": createdAt,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        code,
        chargeType,
        serviceFee,
        logo,
        createdAt,
      ];
}
