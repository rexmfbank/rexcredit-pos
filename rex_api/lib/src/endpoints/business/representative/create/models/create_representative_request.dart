import 'package:equatable/equatable.dart';

class CreateRepresentativeRequest extends Equatable {
  final String firstName;
  final String lastName;
  final String? middleName;
  final String dateOfBirth;
  final String email;
  final String phoneNumber;

  CreateRepresentativeRequest(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'phoneNumber': phoneNumber
    };
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        middleName,
        dateOfBirth,
        email,
        phoneNumber,
      ];
}
