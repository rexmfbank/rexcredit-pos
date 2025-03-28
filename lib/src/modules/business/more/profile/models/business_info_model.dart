import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';

class BusinessInfoViewModel {
  final TextEditingController businessNameController;
  final TextEditingController businessEmailController;
  final TextEditingController businessRegNumberController;
  final TextEditingController businessAddressController;
  final TextEditingController businessPhoneController;
  final TextEditingController businessYearsInLocationController;
  final String addressDtoStreet;
  final String businessType;
  final String registrationNumber;
  final String businessEmail;
  final String businessState;
  final String businessCity;
  final String mobileNumber;
  final String businessName;
  final int yearsInLocation;
  final int startYear;
  final int startMonth;
  final String businessSector;
  final String businessLogo;
  final List<LGAsResponse>? stateLgaResponse;
  final GlobalKey<FormState> formKey;

  BusinessInfoViewModel({
    required this.businessNameController,
    required this.businessEmailController,
    required this.businessRegNumberController,
    required this.businessAddressController,
    required this.businessPhoneController,
    required this.businessYearsInLocationController,
    required this.addressDtoStreet,
    required this.businessType,
    required this.registrationNumber,
    required this.businessEmail,
    required this.businessState,
    required this.businessCity,
    required this.mobileNumber,
    required this.businessName,
    required this.yearsInLocation,
    required this.startYear,
    required this.startMonth,
    required this.businessSector,
    required this.businessLogo,
    required this.stateLgaResponse,
    required this.formKey,
  });

  @override
  BusinessInfoViewModel copyWith({
    TextEditingController? businessNameController,
    TextEditingController? businessEmailController,
    TextEditingController? businessRegNumberController,
    TextEditingController? businessPhoneController,
    TextEditingController? businessAddressController,
    TextEditingController? businessYearsInLocationController,
    String? addressDtoStreet,
    String? businessType,
    String? registrationNumber,
    String? businessEmail,
    String? mobileNumber,
    String? businessName,
    int? yearsInLocation,
    int? startYear,
    int? startMonth,
    String? businessSector,
    String? businessLogo,
    String? businessState,
    String? businessCity,
    List<LGAsResponse>? stateLgaResponse,
    GlobalKey<FormState>? formKey,
  }) {
    return BusinessInfoViewModel(
      businessNameController:
          businessNameController ?? this.businessNameController,
      businessEmailController:
          businessEmailController ?? this.businessEmailController,
      businessAddressController:
          businessAddressController ?? this.businessAddressController,
      businessPhoneController:
          businessPhoneController ?? this.businessPhoneController,
      businessRegNumberController:
          businessRegNumberController ?? this.businessRegNumberController,
      businessYearsInLocationController: businessYearsInLocationController ??
          this.businessYearsInLocationController,
      addressDtoStreet: addressDtoStreet ?? this.addressDtoStreet,
      businessType: businessType ?? this.businessType,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      businessEmail: businessEmail ?? this.businessEmail,
      businessState: businessState ?? this.businessState,
      businessCity: businessCity ?? this.businessCity,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      businessName: businessName ?? this.businessName,
      yearsInLocation: yearsInLocation ?? this.yearsInLocation,
      startYear: startYear ?? this.startYear,
      startMonth: startMonth ?? this.startMonth,
      businessSector: businessSector ?? this.businessSector,
      businessLogo: businessLogo ?? this.businessLogo,
      stateLgaResponse: stateLgaResponse ?? this.stateLgaResponse,
      formKey: formKey ?? this.formKey,
    );
  }
}
