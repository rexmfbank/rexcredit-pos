import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/onboarding/register/models/business_detail_dto.dart';
import 'package:rex_api/src/endpoints/onboarding/register/models/personal_detail_dto.dart';
import 'package:rex_api/src/endpoints/shared_models/api_device_meta.dart';

class RegisterRequest extends Equatable {
  final String customerType;
  final PersonalDetailDto personalDetailDto;
  final BusinessDetailDto businessDetailDto;
  final String onboardingId;
  final String password;
  final String bvn;
  final String language;
  final String username;
  final bool termsAndCondition;
  final String countryCode;
  final ApiDeviceMeta meta;
  final String employmentCategory;
  final String annualIncomeRange;
  final String nationalId;

  const RegisterRequest({
    required this.customerType,
    required this.personalDetailDto,
    required this.businessDetailDto,
    required this.onboardingId,
    required this.password,
    required this.bvn,
    required this.language,
    required this.username,
    required this.termsAndCondition,
    required this.countryCode,
    required this.meta,
    required this.employmentCategory,
    required this.annualIncomeRange,
    required this.nationalId,
  });

  Map<String, dynamic> toJson() => {
        "personalDetailDto": personalDetailDto.toJson(),
        "businessDetailDto": businessDetailDto.toJson(),
        "onboardingId": onboardingId,
        "customerType": customerType,
        "password": password,
        "bvn": bvn,
        "language": language,
        "username": username,
        "accept_t_and_c": termsAndCondition,
        "country_code": countryCode,
        "meta": meta.toJson(),
        "employmentCategory": employmentCategory,
        "annualIncomeRange": annualIncomeRange,
        "nationalId": nationalId
      };

  @override
  List<Object?> get props => [
        personalDetailDto,
        businessDetailDto,
        onboardingId,
        customerType,
        password,
        bvn,
        language,
        username,
        termsAndCondition,
        countryCode,
        meta,
        employmentCategory,
        annualIncomeRange,
        nationalId,
      ];
}
