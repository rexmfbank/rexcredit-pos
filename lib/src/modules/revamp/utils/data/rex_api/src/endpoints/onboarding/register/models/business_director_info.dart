import 'package:equatable/equatable.dart';

class BusinessDirectorInfo extends Equatable {
  final String entityCode;
  final String customerId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  final String mobileNumber;
  final String percentageOfShares;
  final String businessCode;
  final String bvn;
  final String address;
  final String dateOfBirth;
  final String gender;
  final String photoLink;

  const BusinessDirectorInfo({
    required this.entityCode,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.email,
    required this.mobileNumber,
    required this.percentageOfShares,
    required this.businessCode,
    required this.bvn,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.photoLink,
  });

  Map<String, dynamic> toJson() => {
        "entityCode": entityCode,
        "customerId": customerId,
        "firstname": firstName,
        "lastname": lastName,
        "middleName": middleName,
        "email": email,
        "mobileNo": mobileNumber,
        "sharePercent": percentageOfShares,
        "businessCode": businessCode,
        "bvn": bvn,
        "address": address,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "photoLink": photoLink
      };

  @override
  String toString() => {
        "CLASS": "BusinessDirectorInfo",
        "entityCode": entityCode,
        "customerId": customerId,
        "firstname": firstName,
        "lastname": lastName,
        "middleName": middleName,
        "email": email,
        "mobileNo": mobileNumber,
        "sharePercent": percentageOfShares,
        "businessCode": businessCode,
        "bvn": bvn,
        "address": address,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "photoLink": photoLink
      }.toString();

  @override
  List<Object?> get props => [
        entityCode,
        customerId,
        firstName,
        lastName,
        middleName,
        email,
        mobileNumber,
        percentageOfShares,
        businessCode,
        bvn,
        address,
        dateOfBirth,
        gender,
        photoLink
      ];
}
