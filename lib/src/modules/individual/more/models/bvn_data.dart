import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/meta_api_response.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/user_next_of_kin.dart';

class BvnData extends Equatable {
  final int userId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final UserNextOfKin? nextOfKin;
  final String? gender;
  final String? selfie;
  final String? referralCode;
  final String? dateOfBirth;
  final String bvn;
  final String? residentialAddress;
  final String? state;
  final String? lga;
  final dynamic account;
  final MetaApiResponse meta;
  final Object? referrer; // initially String?
  final String createdAt;

  const BvnData({
    required this.userId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.nextOfKin,
    this.gender,
    this.selfie,
    required this.referralCode,
    required this.dateOfBirth,
    required this.bvn,
    this.residentialAddress,
    this.state,
    this.lga,
    this.account,
    required this.meta,
    this.referrer,
    required this.createdAt,
  });

  const BvnData.empty()
      : userId = 0,
        firstName = '',
        middleName = null,
        lastName = '',
        nextOfKin = const UserNextOfKin.empty(),
        gender = null,
        selfie = null,
        referralCode = '',
        dateOfBirth = '',
        bvn = '',
        residentialAddress = null,
        state = null,
        lga = null,
        account = null,
        meta = const MetaApiResponse.empty(),
        referrer = null,
        createdAt = '';

  factory BvnData.fromJson(Map<String, dynamic> json) {
    return BvnData(
      userId: json['user_id'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      nextOfKin: json['next_of_kin'] == null
          ? null
          : UserNextOfKin.fromJson(json['next_of_kin']),
      gender: json['gender'],
      selfie: json['selfie'],
      referralCode: json['referral_code'],
      dateOfBirth: json['date_of_birth'],
      bvn: json['bvn'],
      residentialAddress: json['residential_address'],
      state: json['state'],
      lga: json['lga'],
      account: json['account'],
      meta: MetaApiResponse.fromJson(json['meta']),
      referrer: json['referrer'],
      createdAt: json['created_at'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "BvnData",
      "userId": userId,
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "nextOfKin": nextOfKin,
      "gender": gender,
      "selfie": selfie,
      "referralCode": referralCode,
      "dateOfBirth": dateOfBirth,
      "bvn": bvn,
      "residentAddress": residentialAddress,
      "state": state,
      "lga": lga,
      "account": account,
      "meta": meta,
      "referrer": referrer,
      "createdAt": createdAt,
    }.toString();
  }

  @override
  List<Object?> get props => [
        userId,
        firstName,
        middleName,
        lastName,
        nextOfKin,
        gender,
        selfie,
        referralCode,
        dateOfBirth,
        bvn,
        residentialAddress,
        state,
        lga,
        account,
        meta,
        referrer,
        createdAt,
      ];
}
