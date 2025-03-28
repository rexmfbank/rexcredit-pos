import 'package:equatable/equatable.dart';

class UserNextOfKin extends Equatable {
  final int id;
  final int userId;
  final String name;
  final int relationshipId;
  final String homeAddress;
  final String phoneNumber;
  final String createdAt;

  const UserNextOfKin({
    required this.id,
    required this.userId,
    required this.name,
    required this.relationshipId,
    required this.homeAddress,
    required this.phoneNumber,
    required this.createdAt,
  });

  const UserNextOfKin.empty()
      : id = 0,
        userId = 0,
        name = '',
        relationshipId = 0,
        homeAddress = '',
        phoneNumber = '',
        createdAt = '';

  factory UserNextOfKin.fromJson(Map<String, dynamic> json) {
    return UserNextOfKin(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      relationshipId: json['relationship_id'],
      homeAddress: json['home_address'],
      phoneNumber: json['phone_number'],
      createdAt: json['created_at'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "UserNextOfKin",
      "id": id,
      "userId": userId,
      "name": name,
      "relationshipId": relationshipId,
      "homeAddress": homeAddress,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        relationshipId,
        homeAddress,
        phoneNumber,
        createdAt,
      ];
}
