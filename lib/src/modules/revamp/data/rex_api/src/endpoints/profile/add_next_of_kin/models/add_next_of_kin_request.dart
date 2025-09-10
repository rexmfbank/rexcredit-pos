import 'package:equatable/equatable.dart';

class AddNextOfKinRequest extends Equatable {
  final String? accountNo;
  final String firstName;
  final String lastName;
  final String relationship;
  final String emailAddress;
  final String mobileNo;
  final String dob;

  const AddNextOfKinRequest({
    this.accountNo,
    required this.firstName,
    required this.lastName,
    required this.relationship,
    required this.emailAddress,
    required this.mobileNo,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountNo': accountNo,
      'firstName': firstName,
      'lastName': lastName,
      'relationship': relationship,
      'dob': dob,
      'emailAddress': emailAddress,
      'mobileNo': mobileNo,
    };
  }

  @override
  List<Object?> get props => [
    accountNo,
    firstName,
    lastName,
    relationship,
    dob,
    emailAddress,
    mobileNo,
  ];
}
