import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';

class CreateAccountForm extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;
  final String referralCode;
  final bool termsAndCondition;
  final DeviceMetaData? meta;

  const CreateAccountForm({
    required this.firstName,
    this.middleName = '',
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
    required this.referralCode,
    required this.termsAndCondition,
    required this.meta,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        meta,
      ];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['middle_name'] = middleName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['password'] = password;
    map['password_confirmation'] = passwordConfirmation;
    map['referral_code'] = referralCode;
    map['accept_t_and_c'] = termsAndCondition;
    map['meta'] = meta?.toJson();
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "CreateAccountWithNumberForm",
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "passwordConfirmation": passwordConfirmation,
      "referralCode": referralCode,
      "termsAndCondition": termsAndCondition,
      "meta": meta,
    }.toString();
  }
}
