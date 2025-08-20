import 'package:equatable/equatable.dart';

class GetNextOfKinData extends Equatable {
  final String? accountNo;
  final String? entityCode;
  final String? firstName;
  final String? lastName;
  final String? relationship;
  final String? emailAddress;
  final String? address;
  final String? mobileNo;
  final String? dob;

  const GetNextOfKinData({
    this.accountNo,
    this.entityCode,
    this.firstName,
    this.lastName,
    this.relationship,
    this.emailAddress,
    this.address,
    this.mobileNo,
    this.dob,
  });

  const GetNextOfKinData.empty()
    : entityCode = '',
      accountNo = null,
      firstName = '',
      lastName = '',
      relationship = '',
      emailAddress = '',
      address = '',
      mobileNo = '',
      dob = null;

  factory GetNextOfKinData.fromJson(Map<String, dynamic> json) {
    return GetNextOfKinData(
      entityCode: json['entityCode'] as String?,
      accountNo: json['accountNo'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      relationship: json['relationship'] as String?,
      emailAddress: json['emailAddress'] as String?,
      address: json['address'] as String?,
      mobileNo: json['mobileNo'] as String?,
      dob: json['dob'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    accountNo,
    entityCode,
    firstName,
    lastName,
    relationship,
    emailAddress,
    address,
    mobileNo,
    dob,
  ];
}
