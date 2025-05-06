import 'package:equatable/equatable.dart';

class CreateRepresentativeData extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;

  CreateRepresentativeData({
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
  });

  const CreateRepresentativeData.empty()
      : firstName = '',
        lastName = '',
        middleName = '',
        email = '',
        phoneNumber = '',
        dateOfBirth = '';

  factory CreateRepresentativeData.fromJson(Map<String, dynamic> json) {
    return CreateRepresentativeData(
      firstName: json['firstName']?? '',
      lastName: json['lastName'] ?? '',
      middleName: json['middleName'] ?? '',
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
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
