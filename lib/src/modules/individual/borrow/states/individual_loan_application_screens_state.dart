import 'package:flutter/widgets.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';

class IndividualLoanApplicationScreensState {
  final bool isLoading;
  final String? error;
  final LoanProductModel? loanProduct;
  final TextEditingController residentialAddressController;
  final TextEditingController noOfDependantsController;
  final TextEditingController addressDateController;
  final ComputeLoanResponseData? computedLoan;
  final String selectedMaritalStatus;
  final String selectedEducationalStatus;
  final String selectedEmploymentStatus;
  final String? loanPurpose;
  final String loanRefNo;
  // final LoanApplicationResponseData? loanApplication;
  final List<String>? maritalStatusOptions;
  final String? selectedDateInAddress;
  final String? selectedResumptionDate;
  final List<String>? educationalStatusOptions;
  final List<String>? employmentStatusOptions;
  final TextEditingController guarantorFirstnameController;
  final TextEditingController guarantorLastnameController;
  final TextEditingController loanDeclineReasonController;
  final String selectedGuarantorRelationship;
  final TextEditingController guarantorEmailController;
  final TextEditingController guarantorPhoneNoController;
  final TextEditingController incomeController;
  final List<LGAsResponse> nigeriaStates;
  final List<LGAsResponse> stateLgas;
  final String selectedNigeriaState;
  final String? selectedEmployerLga;
  final List<String> publicAgencyOptions;
  final String? selectedAgency;
  final String? selectedEmploymentType;
  final GlobalKey<FormState> formKey;
  final TextEditingController employerNameController;
  final TextEditingController employerAddressController;
  final List<String> companyIndustries;
  final String? offerPDFLink;
  final bool? loanOfferAccepted;
  final bool? loanOfferDeclined;
  final String selectedIndustry;

  const IndividualLoanApplicationScreensState(
      {required this.isLoading,
      this.error,
      required this.residentialAddressController,
      this.computedLoan,
      this.loanProduct,
      required this.addressDateController,
      required this.noOfDependantsController,
      required this.selectedMaritalStatus,
      required this.selectedEducationalStatus,
      required this.selectedEmploymentStatus,
      required this.loanDeclineReasonController,
      this.loanPurpose,
      required this.loanRefNo,
      // this.loanApplication,
      this.maritalStatusOptions,
      this.selectedDateInAddress,
      this.selectedResumptionDate,
      this.educationalStatusOptions,
      this.employmentStatusOptions,
      required this.guarantorFirstnameController,
      required this.guarantorLastnameController,
      required this.selectedGuarantorRelationship,
      required this.guarantorEmailController,
      required this.guarantorPhoneNoController,
      required this.incomeController,
      required this.employerNameController,
      required this.employerAddressController,
      required this.nigeriaStates,
      required this.stateLgas,
      required this.selectedNigeriaState,
      required this.selectedEmployerLga,
      required this.publicAgencyOptions,
      required this.selectedAgency,
      required this.companyIndustries,
      required this.selectedIndustry,
      required this.selectedEmploymentType,
      this.offerPDFLink,
      this.loanOfferAccepted,
      this.loanOfferDeclined,
      required this.formKey});

  IndividualLoanApplicationScreensState copyWith(
      {bool? isLoading,
      String? error,
      TextEditingController? residentialAddressController,
      TextEditingController? noOfDependantsController,
      TextEditingController? addressDateController,
      ComputeLoanResponseData? computedLoan,
      LoanProductModel? loanProduct,
      String? selectedMaritalStatus,
      String? selectedEducationalStatus,
      String? selectedEmploymentStatus,
      String? loanPurpose,
      String? loanRefNo,
      // LoanApplicationResponseData? loanApplication,
      List<String>? maritalStatusOptions,
      String? selectedDateInAddress,
      String? selectedResumptionDate,
      List<String>? educationalStatusOptions,
      List<String>? employmentStatusOptions,
      TextEditingController? guarantorFirstnameController,
      TextEditingController? guarantorLastnameController,
      TextEditingController? guarantorEmailController,
      TextEditingController? guarantorPhoneNoController,
      TextEditingController? loanDeclineReasonController,
      String? selectedGuarantorRelationship,
      List<String>? guarantorRelationshipOptions,
      TextEditingController? incomeController,
      TextEditingController? employerNameController,
      TextEditingController? employerAddressController,
      List<LGAsResponse>? nigeriaStates,
      List<LGAsResponse>? stateLgas,
      String? selectedNigeriaState,
      String? selectedEmployerLga,
      List<String>? publicAgencyOptions,
      String? selectedAgency,
      String? selectedEmploymentType,
      List<String>? companyIndustries,
      String? selectedIndustry,
      String? offerPDFLink,
      bool? loanOfferAccepted,
      bool? loanOfferDeclined,
      GlobalKey<FormState>? formKey}) {
    return IndividualLoanApplicationScreensState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        residentialAddressController:
            residentialAddressController ?? this.residentialAddressController,
        addressDateController:
            addressDateController ?? this.addressDateController,
        noOfDependantsController:
            noOfDependantsController ?? this.noOfDependantsController,
        loanDeclineReasonController:
            loanDeclineReasonController ?? this.loanDeclineReasonController,
        computedLoan: computedLoan ?? this.computedLoan,
        loanProduct: loanProduct ?? this.loanProduct,
        selectedMaritalStatus:
            selectedMaritalStatus ?? this.selectedMaritalStatus,
        selectedEducationalStatus:
            selectedEducationalStatus ?? this.selectedEducationalStatus,
        selectedEmploymentStatus:
            selectedEmploymentStatus ?? this.selectedEmploymentStatus,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        loanRefNo: loanRefNo ?? this.loanRefNo,
        // loanApplication: loanApplication ?? this.loanApplication,
        maritalStatusOptions: maritalStatusOptions ?? this.maritalStatusOptions,
        selectedDateInAddress:
            selectedDateInAddress ?? this.selectedDateInAddress,
        selectedResumptionDate:
            selectedResumptionDate ?? this.selectedResumptionDate,
        educationalStatusOptions:
            educationalStatusOptions ?? this.educationalStatusOptions,
        employmentStatusOptions:
            employmentStatusOptions ?? this.employmentStatusOptions,
        guarantorFirstnameController:
            guarantorFirstnameController ?? this.guarantorFirstnameController,
        guarantorLastnameController:
            guarantorLastnameController ?? this.guarantorLastnameController,
        guarantorEmailController:
            guarantorEmailController ?? this.guarantorEmailController,
        guarantorPhoneNoController:
            guarantorPhoneNoController ?? this.guarantorPhoneNoController,
        selectedGuarantorRelationship:
            selectedGuarantorRelationship ?? this.selectedGuarantorRelationship,
        incomeController: incomeController ?? this.incomeController,
        employerNameController:
            employerNameController ?? this.employerNameController,
        employerAddressController:
            employerAddressController ?? this.employerAddressController,
        nigeriaStates: nigeriaStates ?? this.nigeriaStates,
        stateLgas: stateLgas ?? this.stateLgas,
        selectedNigeriaState: selectedNigeriaState ?? this.selectedNigeriaState,
        selectedEmployerLga: selectedEmployerLga ?? this.selectedEmployerLga,
        selectedAgency: selectedAgency ?? this.selectedAgency,
        selectedEmploymentType:
            selectedEmploymentType ?? this.selectedEmploymentType,
        publicAgencyOptions: publicAgencyOptions ?? this.publicAgencyOptions,
        companyIndustries: companyIndustries ?? this.companyIndustries,
        selectedIndustry: selectedIndustry ?? this.selectedIndustry,
        offerPDFLink: offerPDFLink ?? this.offerPDFLink,
        loanOfferAccepted: loanOfferAccepted ?? this.loanOfferAccepted,
        loanOfferDeclined: loanOfferDeclined ?? this.loanOfferDeclined,
        formKey: formKey ?? this.formKey);
  }

  factory IndividualLoanApplicationScreensState.initial() {
    return IndividualLoanApplicationScreensState(
        isLoading: false,
        residentialAddressController: TextEditingController(),
        noOfDependantsController: TextEditingController(),
        addressDateController: TextEditingController(),
        selectedEducationalStatus: "",
        selectedMaritalStatus: "",
        selectedEmploymentStatus: "",
        loanRefNo: "",
        guarantorFirstnameController: TextEditingController(),
        guarantorLastnameController: TextEditingController(),
        guarantorEmailController: TextEditingController(),
        guarantorPhoneNoController: TextEditingController(),
        loanDeclineReasonController: TextEditingController(),
        selectedGuarantorRelationship: "",
        incomeController: TextEditingController(),
        employerNameController: TextEditingController(),
        employerAddressController: TextEditingController(),
        nigeriaStates: [],
        stateLgas: [],
        selectedNigeriaState: '',
        selectedEmployerLga: '',
        publicAgencyOptions: [],
        selectedAgency: '',
        selectedEmploymentType: '',
        companyIndustries: [],
        selectedIndustry: '',
        offerPDFLink: '',
        loanOfferAccepted: false,
        loanOfferDeclined: false,
        formKey: GlobalKey<FormState>());
  }
}
