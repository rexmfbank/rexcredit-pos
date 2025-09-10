import 'package:equatable/equatable.dart';

class UpdateBusinessResponseData extends Equatable {
  final String entityCode;
  final String? accountNo;
  final String firstName;
  final String lastName;
  final String relationship;
  final String emailAddress;
  final String mobileNo;
  final String dob;

  const UpdateBusinessResponseData({
    required this.entityCode,
    this.accountNo,
    required this.firstName,
    required this.lastName,
    required this.relationship,
    required this.emailAddress,
    required this.mobileNo,
    required this.dob,
  });

  const UpdateBusinessResponseData.empty()
    : entityCode = '',
      accountNo = null,
      firstName = '',
      lastName = '',
      relationship = '',
      emailAddress = '',
      mobileNo = '',
      dob = '';

  factory UpdateBusinessResponseData.fromJson(Map<String, dynamic> json) {
    return UpdateBusinessResponseData(
      entityCode: json['entityCode'] as String,
      accountNo: json['accountNo'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      relationship: json['relationship'] as String,
      emailAddress: json['emailAddress'] as String,
      mobileNo: json['mobileNo'] as String,
      dob: json['dob'] as String,
    );
  }

  @override
  List<Object?> get props => [
    entityCode,
    accountNo,
    firstName,
    lastName,
    relationship,
    emailAddress,
    mobileNo,
    dob,
  ];
}
