import 'package:equatable/equatable.dart';

class PersonalDetailDto extends Equatable {
  final String firstName;
  final String lastName;
  final String middleName;
  final String mobileNumber;
  final String email;
  final String dateOfBirth;
  final String gender;
  final String photoLink;
  final String employmentStatus;
  final String occupation;
  final String bvn;

  const PersonalDetailDto({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.mobileNumber,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.photoLink,
    required this.employmentStatus,
    required this.occupation,
    required this.bvn,
  });

  Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "lastname": lastName,
        "middleName": middleName,
        "mobileNo": mobileNumber,
        "email": email,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "photoLink": photoLink,
        "employmentStatus": employmentStatus,
        "occupation": occupation,
        "bvn": bvn
      };

  @override
  String toString() => {
        "CLASS": "PersonalDetail",
        "firstname": firstName,
        "lastname": lastName,
        "middleName": middleName,
        "mobileNo": mobileNumber,
        "email": email,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "photoLink": photoLink,
        "employmentStatus": employmentStatus,
        "occupation": occupation,
        "bvn": bvn
      }.toString();

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        middleName,
        mobileNumber,
        email,
        dateOfBirth,
        gender,
        photoLink,
        employmentStatus,
        occupation,
        bvn,
      ];
}
