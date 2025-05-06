import 'package:equatable/equatable.dart';

class AddDirectorsRequestData extends Equatable {
  final String? entityCode;
  final String customerId;
  final String lastname;
  final String firstname;
  final String? middlename;
  final String email;
  final String businessCode;
  final String sharePercent;
  final String bvn;
  final String gender;
  final String mobileNo;
  final String dateOfBirth;
  final String photoLink;

  AddDirectorsRequestData(
      {this.entityCode,
      required this.customerId,
      required this.firstname,
      required this.lastname,
      this.middlename,
      required this.email,
      required this.businessCode,
      required this.sharePercent,
      required this.mobileNo,
      required this.gender,
      required this.bvn,
      required this.photoLink,
      required this.dateOfBirth});

  AddDirectorsRequestData.empty()
      : entityCode = '',
        customerId = '',
        firstname = '',
        lastname = '',
        middlename = '',
        email = '',
        businessCode = '',
        sharePercent = '',
        mobileNo = '',
        gender = '',
        bvn = '',
        photoLink = '',
        dateOfBirth = '';

  Map<String, dynamic> toJson() {
    return {
      'entityCode': entityCode,
      'customerId': customerId,
      'firstname': firstname,
      'lastname': lastname,
      'middlename': middlename,
      'businessCode': businessCode,
      'sharePercent': sharePercent,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'mobileNo': mobileNo,
      'gender': gender,
      'bvn': bvn,
      'photoLink': photoLink
    };
  }

  @override
  List<Object?> get props => [
        entityCode,
        customerId,
        firstname,
        lastname,
        middlename,
        businessCode,
        sharePercent,
        dateOfBirth,
        gender,
        email,
        mobileNo,
        bvn,
        photoLink
      ];
}
