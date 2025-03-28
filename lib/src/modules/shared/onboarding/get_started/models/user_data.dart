import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/user_account_detail.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/user_document.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/user_next_of_kin.dart';

class UserData extends Equatable {
  final int? id;
  final String? fullName;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final bool? verified;
  final String? bvn;
  final UserAccountDetail? account;
  final String? gender;
  final String? referralCode;
  final String? dateOfBirth;
  final String? residentialAddress;
  final String? state;
  final String? localGovt;
  final bool? securityQuestion;
  final String? greeting;
  final List<UserDocument>? documents;
  final String? selfie;
  final String? loan;
  final bool? loanEligible;
  final bool? uncompletedLoan;
  final UserNextOfKin? nextOfKin;
  final String? createdAt;

  const UserData({
    this.id,
    this.fullName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.verified,
    this.bvn,
    this.account,
    this.gender,
    this.referralCode,
    this.dateOfBirth,
    this.residentialAddress,
    this.state,
    this.localGovt,
    this.securityQuestion,
    this.greeting,
    this.documents,
    this.selfie,
    this.loan,
    this.loanEligible,
    this.uncompletedLoan,
    this.nextOfKin,
    this.createdAt,
  });

  const UserData.empty()
      : id = null,
        fullName = null,
        firstName = null,
        middleName = null,
        lastName = null,
        email = null,
        phoneNumber = null,
        verified = null,
        bvn = null,
        account = null,
        gender = null,
        referralCode = null,
        dateOfBirth = null,
        residentialAddress = null,
        state = null,
        localGovt = null,
        securityQuestion = null,
        greeting = null,
        documents = null,
        selfie = null,
        loan = null,
        loanEligible = null,
        uncompletedLoan = null,
        nextOfKin = null,
        createdAt = null;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      fullName: json['fullname'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      verified: json['verified'],
      bvn: json['bvn'],
      account: json['account'] == null
          ? null
          : UserAccountDetail.fromJson(json['account']),
      gender: json['gender'],
      referralCode: json['referral_code'],
      dateOfBirth: json['date_of_birth'],
      residentialAddress: json['residential_address'],
      state: json['state'],
      localGovt: json['local_govt'],
      securityQuestion: json['security_question'],
      greeting: json['greeting'],
      documents: json['documents'] != null
          ? List<UserDocument>.from(
              json['documents'].map((x) => UserDocument.fromJson(x)))
          : null,
      selfie: json['selfie'],
      loan: json['loan'],
      loanEligible: json['loan_eligible'],
      uncompletedLoan: json['uncompleted_loan'],
      nextOfKin: json['next_of_kin'] == null
          ? null
          : UserNextOfKin.fromJson(json['next_of_kin']),
      createdAt: json['created_at'],
    );
  }

  UserData copyWith({
    int? id,
    String? fullName,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneNumber,
    bool? verified,
    String? bvn,
    UserAccountDetail? account,
    String? gender,
    String? referralCode,
    String? dateOfBirth,
    String? residentialAddress,
    String? state,
    String? localGovt,
    bool? securityQuestion,
    String? greeting,
    List<UserDocument>? documents,
    String? selfie,
    String? loan,
    bool? loanEligible,
    bool? uncompletedLoan,
    UserNextOfKin? nextOfKin,
    String? createdAt,
  }) {
    return UserData(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verified: verified ?? this.verified,
      bvn: bvn ?? this.bvn,
      account: account ?? this.account,
      gender: gender ?? this.gender,
      referralCode: referralCode ?? this.referralCode,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      residentialAddress: residentialAddress ?? this.residentialAddress,
      state: state ?? this.state,
      localGovt: localGovt ?? this.localGovt,
      securityQuestion: securityQuestion ?? this.securityQuestion,
      greeting: greeting ?? this.greeting,
      documents: documents ?? this.documents,
      selfie: selfie ?? this.selfie,
      loan: loan ?? this.loan,
      loanEligible: loanEligible ?? this.loanEligible,
      uncompletedLoan: uncompletedLoan ?? this.uncompletedLoan,
      nextOfKin: nextOfKin ?? this.nextOfKin,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "UserData",
      "id": id,
      "fullname": fullName,
      "firstname": firstName,
      "middlename": middleName,
      "lastname": lastName,
      "email": email,
      "phonenumber": phoneNumber,
      "verified": verified,
      "bvn": bvn,
      "account": account,
      "gender": gender,
      "referralCode": referralCode,
      "dateOfBirth": dateOfBirth,
      "address": residentialAddress,
      "state": state,
      "lga": localGovt,
      "securityQuestion": securityQuestion,
      "greeting": greeting,
      "documents": documents,
      "selfie": selfie,
      "loan": loan,
      "loanEligible": loanEligible,
      "uncompletedLoan": uncompletedLoan,
      "nextOfKin": nextOfKin,
      "createdAt": createdAt,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        firstName,
        middleName,
        lastName,
        email,
        phoneNumber,
        verified,
        bvn,
        account,
        gender,
        referralCode,
        dateOfBirth,
        residentialAddress,
        state,
        localGovt,
        securityQuestion,
        greeting,
        documents,
        selfie,
        loan,
        loanEligible,
        uncompletedLoan,
        nextOfKin,
        createdAt,
      ];
}
