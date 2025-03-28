import 'package:equatable/equatable.dart';

class FetchRepresentativeData extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;

  FetchRepresentativeData(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth});

  const FetchRepresentativeData.empty()
      : firstName = '',
        lastName = '',
        middleName = '',
        email = '',
        phoneNumber = '',
        dateOfBirth = '';

  factory FetchRepresentativeData.fromJson(Map<String, dynamic> json) {
    return FetchRepresentativeData(
      firstName: json['firstname'],
      lastName: json['lastname'],
      middleName: json['middlename'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'],
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        middleName,
        email,
        phoneNumber,
        dateOfBirth,
      ];
}
