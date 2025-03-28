import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/onboarding/register/models/business_director_info.dart';

class BusinessDetailDto extends Equatable {
  final String businessType;
  final String registrationNumber;
  final String businessRegistered;
  final String businessRegistrationLink;
  final String businessEmail;
  final String businessAddress;
  final String taxNumber;
  final String mobileNumber;
  final String businessName;
  final int yearsInBusiness;
  final String businessSector;
  final String businessLogo;
  final List<BusinessDirectorInfo> directorInfoList;

  const BusinessDetailDto({
    required this.businessType,
    required this.registrationNumber,
    required this.businessRegistered,
    required this.businessRegistrationLink,
    required this.businessEmail,
    required this.businessAddress,
    required this.taxNumber,
    required this.mobileNumber,
    required this.businessName,
    required this.yearsInBusiness,
    required this.businessSector,
    required this.businessLogo,
    required this.directorInfoList,
  });

  Map<String, dynamic> toJson() => {
        "businessType": businessType,
        "registrationNo": registrationNumber,
        "businessRegistered": businessRegistered,
        "businessRegistrationLink": businessRegistrationLink,
        "businessEmail": businessEmail,
        "businessAddress": businessAddress,
        "taxNo": taxNumber,
        "mobileNo": mobileNumber,
        "businessName": businessName,
        "noOfYearsInBusiness": yearsInBusiness,
        "businessSector": businessSector,
        "businessLogo": businessLogo,
        "directorInfoList": directorInfoList.map((e) => e.toJson()).toList(),
      };

  BusinessDetailDto copyWith({
    String? businessType,
    String? registrationNumber,
    String? businessRegistered,
    String? businessRegistrationLink,
    String? businessEmail,
    String? businessAddress,
    String? taxNumber,
    String? mobileNumber,
    String? businessName,
    int? yearsInBusiness,
    String? businessSector,
    String? businessLogo,
    List<BusinessDirectorInfo>? directorInfoList,
  }) {
    return BusinessDetailDto(
      businessType: businessType ?? this.businessType,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      businessRegistered: businessRegistered ?? this.businessRegistered,
      businessRegistrationLink:
          businessRegistrationLink ?? this.businessRegistrationLink,
      businessEmail: businessEmail ?? this.businessEmail,
      businessAddress: businessAddress ?? this.businessAddress,
      taxNumber: taxNumber ?? this.taxNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      businessName: businessName ?? this.businessName,
      yearsInBusiness: yearsInBusiness ?? this.yearsInBusiness,
      businessSector: businessSector ?? this.businessSector,
      businessLogo: businessLogo ?? this.businessLogo,
      directorInfoList: directorInfoList ?? this.directorInfoList,
    );
  }

  @override
  List<Object?> get props => [
        businessType,
        registrationNumber,
        businessRegistered,
        businessRegistrationLink,
        businessEmail,
        businessAddress,
        taxNumber,
        mobileNumber,
        businessName,
        yearsInBusiness,
        businessSector,
        businessLogo,
        directorInfoList,
      ];
}
