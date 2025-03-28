import 'package:flutter/widgets.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';

class BusinessInformationScreenState {
  final bool isLoading;
  final String? error;
  final TextEditingController businessNameController;
  final TextEditingController businessEmailController;
  final TextEditingController businessAddressController;
  final TextEditingController businessPhoneController;
  final TextEditingController businessRegNumberController;
  final TextEditingController businessYearsInLocationController;
  final String? selectedBusinessType;
  final String? selectedBusinessSector;
  final String? businessState;
  final String? businessLga;
  final String? businessLogo;
  final String yearsInLocation;
  final int? startYear;
  final int? startMonth;
  final List<LGAsResponse>? stateLgaResponse;
  final GlobalKey<FormState> formKey;

  final List<String> businessTypeList;
  final List<String> industryList;

  const BusinessInformationScreenState({
    required this.isLoading,
    this.error,
    required this.businessNameController,
    required this.businessEmailController,
    required this.businessAddressController,
    required this.businessPhoneController,
    required this.businessRegNumberController,
    required this.businessYearsInLocationController,
    this.selectedBusinessType,
    this.selectedBusinessSector,
    this.businessState,
    this.businessLga,
    this.businessLogo,
    required this.yearsInLocation,
    this.startMonth,
    this.startYear,
    this.stateLgaResponse,
    required this.businessTypeList,
    required this.industryList,
    required this.formKey,
  });

  BusinessInformationScreenState copyWith({
    bool? isLoading,
    String? error,
    TextEditingController? businessNameController,
    TextEditingController? businessEmailController,
    TextEditingController? businessAddressController,
    TextEditingController? businessPhoneController,
    TextEditingController? businessRegNumberController,
    TextEditingController? businessYearsInLocationController,
    String? selectedBusinessType,
    String? selectedBusinessSector,
    String? businessState,
    String? businessLga,
    String? businessLogo,
    String? yearsInLocation,
    int? startYear,
    int? startMonth,
    List<LGAsResponse>? stateLgaResponse,
    List<String>? businessTypeList,
    List<String>? industryList,
    GlobalKey<FormState>? formKey,
  }) {
    return BusinessInformationScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
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
      selectedBusinessType: selectedBusinessType ?? this.selectedBusinessType,
      selectedBusinessSector:
          selectedBusinessSector ?? this.selectedBusinessSector,
      businessLogo: businessLogo ?? this.businessLogo,
      businessState: businessState ?? this.businessState,
      businessLga: businessLga ?? this.businessLga,
      yearsInLocation: yearsInLocation ?? this.yearsInLocation,
      startYear: startYear ?? this.startYear,
      startMonth: startMonth ?? this.startMonth,
      stateLgaResponse: stateLgaResponse ?? this.stateLgaResponse,
      businessTypeList: businessTypeList ?? this.businessTypeList,
      industryList: industryList ?? this.industryList,
      formKey: formKey ?? this.formKey,
    );
  }

  factory BusinessInformationScreenState.initial() {
    return BusinessInformationScreenState(
      isLoading: false,
      businessNameController: TextEditingController(),
      businessEmailController: TextEditingController(),
      businessAddressController: TextEditingController(),
      businessPhoneController: TextEditingController(),
      businessRegNumberController: TextEditingController(),
      businessYearsInLocationController: TextEditingController(),
      selectedBusinessType: '',
      selectedBusinessSector: '',
      yearsInLocation: '',
      startYear: 1900,
      startMonth: 1,
      businessLogo: '',
      businessState: '',
      businessLga: '',
      businessTypeList: [
        'Sole Proprietorship',
        'Limited Liability Company',
        'Partnership'
      ],
      industryList: [
        'Manufacturing',
        'Retail',
        'Hospitality',
        "Education",
        "Non-Governmental Organization",
        "Oil & Gas",
        "Information and Communications Technology",
        "Healthcare",
        "Financial Services",
        "Construction/Real Estate",
        "Agriculture",
        "Sports Betting",
        "Printing/publishing",
        "Advertising",
      ],
      formKey: GlobalKey<FormState>(),
    );
  }
}
