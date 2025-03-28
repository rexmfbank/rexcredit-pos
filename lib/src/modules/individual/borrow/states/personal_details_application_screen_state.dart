import 'package:flutter/widgets.dart';
import 'package:rex_api/rex_api.dart';

class PersonalDetailsApplicationScreenState {
  final bool isLoading;
  final String? error;
  final TextEditingController residentialAddressController;
  final TextEditingController noOfDependantsController;
  final ComputeLoanResponseData? computedLoan;
  final String loanRefNo;
  final String selectedMaritalStatus;
  final String selectedEducationalStatus;
  final String selectedEmploymentStatus;
  final List<String>? maritalStatusOptions;
  final String? selectedDate;
  final List<String>? educationalStatusOptions;
  final List<String>? employmentStatusOptions;
  final GlobalKey<FormState> formKey;

  const PersonalDetailsApplicationScreenState(
      {required this.isLoading,
      this.error,
      required this.residentialAddressController,
      this.computedLoan,
      required this.loanRefNo,
      required this.noOfDependantsController,
      required this.selectedMaritalStatus,
      required this.selectedEducationalStatus,
      required this.selectedEmploymentStatus,
      // this.loanApplication,
      this.maritalStatusOptions,
      this.selectedDate,
      this.educationalStatusOptions,
      this.employmentStatusOptions,
      required this.formKey});

  PersonalDetailsApplicationScreenState copyWith({
    bool? isLoading,
    String? error,
    TextEditingController? residentialAddressController,
    TextEditingController? noOfDependantsController,
    ComputeLoanResponseData? computedLoan,
    String? loanRefNo,
    String? selectedMaritalStatus,
    String? selectedEducationalStatus,
    String? selectedEmploymentStatus,
    List<String>? maritalStatusOptions,
    String? selectedDate,
    List<String>? educationalStatusOptions,
    List<String>? employmentStatusOptions,
    GlobalKey<FormState>? formKey,
  }) {
    return PersonalDetailsApplicationScreenState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        residentialAddressController:
            residentialAddressController ?? this.residentialAddressController,
        noOfDependantsController:
            noOfDependantsController ?? this.noOfDependantsController,
        computedLoan: computedLoan ?? this.computedLoan,
        loanRefNo: loanRefNo ?? this.loanRefNo,
        selectedMaritalStatus:
            selectedMaritalStatus ?? this.selectedMaritalStatus,
        selectedEducationalStatus:
            selectedEducationalStatus ?? this.selectedEducationalStatus,
        selectedEmploymentStatus:
            selectedEmploymentStatus ?? this.selectedEmploymentStatus,
        maritalStatusOptions: maritalStatusOptions ?? this.maritalStatusOptions,
        selectedDate: selectedDate ?? this.selectedDate,
        educationalStatusOptions:
            educationalStatusOptions ?? this.educationalStatusOptions,
        employmentStatusOptions:
            employmentStatusOptions ?? this.employmentStatusOptions,
        formKey: formKey ?? this.formKey);
  }

  factory PersonalDetailsApplicationScreenState.initial() {
    return PersonalDetailsApplicationScreenState(
        isLoading: false,
        residentialAddressController: TextEditingController(),
        noOfDependantsController: TextEditingController(),
        loanRefNo: "",
        selectedEducationalStatus: "",
        selectedMaritalStatus: "",
        selectedEmploymentStatus: "",
        formKey: GlobalKey<FormState>());
  }
}
