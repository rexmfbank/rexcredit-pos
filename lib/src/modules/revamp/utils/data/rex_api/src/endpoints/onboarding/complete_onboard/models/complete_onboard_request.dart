import 'package:equatable/equatable.dart';
import 'address_dto.dart';
import 'customer_document_dto.dart';
import '../../register/models/business_detail_dto.dart';

class CompleteOnboardRequest extends Equatable {
  final String onboardingId;
  final AddressDto addressDto;
  final String username;
  final String gender;
  final String customerType;
  final String referralCode;
  final String language;
  final List<CustomerDocumentDto> documents;
  final BusinessDetailDto businessDetailDto;
  final String employmentCategory;
  final String annualIncomeRange;
  final String nationalId;

  const CompleteOnboardRequest({
    required this.onboardingId,
    required this.addressDto,
    required this.username,
    required this.gender,
    required this.customerType,
    required this.referralCode,
    required this.language,
    required this.documents,
    required this.businessDetailDto,
    required this.employmentCategory,
    required this.annualIncomeRange,
    required this.nationalId,
  });

  Map<String, dynamic> toJson() => {
        "customerType": customerType,
        "onboardingId": onboardingId,
        "addressDto": addressDto.toJson(),
        "username": username,
        "gender": gender,
        "referralCode": referralCode,
        "language": language,
        "documents": documents.map((e) => e.toJson()).toList(),
        "businessDetailDto": businessDetailDto,
        "employmentCategory": employmentCategory,
        "annualIncomeRange": annualIncomeRange,
        "nationalId": nationalId
      };

  @override
  List<Object?> get props => [
        onboardingId,
        addressDto,
        username,
        gender,
        customerType,
        referralCode,
        language,
        documents,
        businessDetailDto,
        employmentCategory,
        annualIncomeRange,
        nationalId,
      ];
}
