import 'package:equatable/equatable.dart';

class UpdateUserRequest extends Equatable {
  final int id;
  final String? firstName;
  final String? middlename;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? entityCode;
  final String? photoLink;

  const UpdateUserRequest({
    required this.id,
    required this.firstName,
    required this.middlename,
    required this.lastName,
    required this.userName,
    required this.entityCode,
    required this.photoLink,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstName,
        "middlename": middlename,
        "lastname": lastName,
        "username": userName,
        "entityCode": entityCode,
        "email": email,
        "photoLink": photoLink,
      };

  @override
  String toString() => {
        "CLASS": "UpdateUserRequest",
        "id": id,
        "firstname": firstName,
        "middlename": middlename,
        "lastname": lastName,
        "username": userName,
        "entityCode": entityCode,
        "email": email,
        "photoLink": photoLink,
      }.toString();

  @override
  List<Object?> get props => [
        id,
        firstName,
        middlename,
        lastName,
        userName,
        entityCode,
        email,
      ];
}
