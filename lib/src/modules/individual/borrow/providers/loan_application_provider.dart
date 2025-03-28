// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/fetch_single_loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/states/individual_loan_application_screens_state.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_confirm_pin_modal_sheet.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_decline_loan.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/constants/string_regex.dart';
import 'package:rex_app/src/utils/enums/loan_application_section.dart';
import 'package:rex_app/src/utils/enums/loan_status.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final selectedLoanApplicationProvider =
    StateProvider<LoanApplicationResponseData?>((ref) => null);

final selectedLoanRefCodeProvider = StateProvider<String>((ref) => '');

final loanApplicationProvider = NotifierProvider<LoanApplicationNotifier,
    IndividualLoanApplicationScreensState>(() => LoanApplicationNotifier());

class LoanApplicationNotifier
    extends Notifier<IndividualLoanApplicationScreensState> with LocatorMix {
  //
  DeviceMetaData? deviceMeta;

  @override
  IndividualLoanApplicationScreensState build() {
    deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
    return IndividualLoanApplicationScreensState.initial();
  }

  void fetchStates() async {
    final json = await _getStates();
    state = state.copyWith(
      nigeriaStates: stateCapitalResponseFromJson(json),
    );
  }

  void setResidentialAddress() {
    state = state.copyWith(
        residentialAddressController: TextEditingController(
            text:
                ref.read(selectedLoanApplicationProvider)?.residentialAddress));
  }

  Future<dynamic> _getStates() async {
    final statesAndLocals = await rootBundle.loadString(JsonAsset.statesLga);

    return jsonDecode(statesAndLocals);
  }

  void setLoanPurpose(String purpose) {
    state = state.copyWith(loanPurpose: purpose);
  }

  void setLoanRefNo(String loanRefNo) {
    state = state.copyWith(loanRefNo: loanRefNo);
  }

  set setSelectedState(String selectedState) {
    state = state.copyWith(selectedNigeriaState: selectedState);
  }

  set setSelectedIndustry(String selectedIndustry) {
    state = state.copyWith(selectedIndustry: selectedIndustry);
  }

  set setSelectedEmployerLga(String selectedLga) {
    state = state.copyWith(selectedEmployerLga: selectedLga);
  }

  set setSelectedAgency(String? selectedAgency) {
    state = state.copyWith(selectedAgency: selectedAgency);
  }

  void setSelectedMaritalStatus(String maritalStatus) {
    state = state.copyWith(selectedMaritalStatus: maritalStatus);
  }

  void setOfferPDFLink(String? offerPDFLink) {
    state = state.copyWith(offerPDFLink: offerPDFLink);
  }

  void setSelectedDate(DateTime? selectedDate) {
    selectedDate != null
        ? state = state.copyWith(
            selectedDateInAddress:
                '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}')
        : state = state.copyWith(selectedDateInAddress: null);
  }

  void setSelectedEducationalStatus(String status) {
    state = state.copyWith(selectedEducationalStatus: status);
  }

  void setSelectedEmploymentStatus(String status) {
    state = state.copyWith(selectedEmploymentStatus: status);
  }

  void setSelectedEmploymentType(String type) {
    state = state.copyWith(selectedEmploymentType: type);
  }

  void setSelectedGuarantorRelationshipStatus(String status) {
    state = state.copyWith(selectedGuarantorRelationship: status);
  }

  void setComputedLoan(ComputeLoanResponseData computedLoan) {
    state = state.copyWith(computedLoan: computedLoan);
  }

  Future<void> applyForLoanStageOne(
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    final computedLoan = state.computedLoan;
    final loanProduct = ref.watch(selectedLoanProductProvider) ??
        const LoanProductModel.empty();
    final selectedLoanApplication =
        ref.watch(selectedLoanApplicationProvider) ??
            LoanApplicationResponseData.empty();
    try {
      var loanApplicationRequest = LoanApplicationStageOneRequest(
        productCode: loanProduct.productCode,
        loanTitle: loanProduct.title,
        section: LoanSection.loan.jsonString,
        amountApplied: computedLoan?.amount?.toDouble() ??
            selectedLoanApplication.amountApplied,
        loanRefNo: null,
        purpose: state.loanPurpose ?? selectedLoanApplication.purpose!,
        tenor: computedLoan?.repaymentCount ?? selectedLoanApplication.tenor!,
        status: LoanStatus.initiated.jsonString,
        maritalStatus: state.selectedMaritalStatus,
        residentialAddress: state.residentialAddressController.text,
        inResidenceSince: state.selectedDateInAddress,
        noOfDependants: int.tryParse(state.noOfDependantsController.text),
        educationalStatus: state.selectedEducationalStatus,
        employmentStatus: state.selectedEmploymentStatus,
      );

      var apiResponse = await RexApi.instance.makeLoanApplicationStageOne(
        authToken: authToken,
        appVersion: ref.read(appVersionProvider),
        request: loanApplicationRequest,
      );
      state =
          state.copyWith(isLoading: false, loanRefNo: apiResponse.data!.refNo);
      ref.read(selectedLoanRefCodeProvider.notifier).state = state.loanRefNo;
      ref.invalidate(fetchSingleLoanApplicationProvider);
      context.pop();
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> applyForLoanGuarantorDetails(
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      var loanApplicationRequest = LoanApplicationGuarantorRequest(
        section: LoanSection.guarantor.jsonString,
        loanRefNo: state.loanRefNo.isBlank
            ? ref.watch(selectedLoanRefCodeProvider)
            : state.loanRefNo,
        guarantorFirstName: state.guarantorFirstnameController.text,
        guarantorLastName: state.guarantorLastnameController.text,
        guarantorRelationship: state.selectedGuarantorRelationship,
        guarantorEmail: state.guarantorEmailController.text,
        guarantorPhoneNumber: state.guarantorPhoneNoController.text,
      );
      debugPrint("LOAN GUARANTOR REQUEST: $loanApplicationRequest");

      var apiResponse = await RexApi.instance.makeLoanApplicationGuarantor(
        authToken: authToken,
        appVersion: ref.read(appVersionProvider),
        request: loanApplicationRequest,
      );
      state =
          state.copyWith(isLoading: false, loanRefNo: apiResponse.data!.refNo);
      ref.read(selectedLoanRefCodeProvider.notifier).state = state.loanRefNo;
      ref.invalidate(fetchSingleLoanApplicationProvider);
      context.pop();
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void onSubmitApplication(BuildContext context) {
    debugPrint("onSubmitApplication clicked!");
    showSuccessModal(
        context,
        StringAssets.submitLoanApplication,
        StringAssets.submitLoanApplicationDesc,
        StringAssets.yesSubmit,
        StringAssets.exclamation, () {
      context.pop();
      updateLoanApplication(context, LoanStatus.applied.jsonString);
    });
  }

  void onValidatePersonalDetails(BuildContext context) {
    final noOfDependants = state.noOfDependantsController.text;
    final maritalStatus = state.selectedMaritalStatus;
    final timeInAddress = state.selectedDateInAddress;
    final educationalStatus = state.selectedEducationalStatus;
    final employmentStatus = state.selectedEmploymentStatus;

    if (maritalStatus.isBlank || maritalStatus == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidMaritalStatus);
      debugPrint("Marital status error");
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.residentialAddressController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidResidentialAddress);
      debugPrint("State error");
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (timeInAddress.isBlank || timeInAddress == StringAssets.selectDate) {
      state = state.copyWith(error: StringAssets.invalidInput);
      debugPrint("TimeInResidence error");
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (noOfDependants.isBlank) {
      state = state.copyWith(error: StringAssets.invalidNoOfDependants);
      debugPrint("Invalid no of dependants error");
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (educationalStatus.isBlank ||
        educationalStatus == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidEducationalStatus);
      debugPrint("Educational status error");
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (employmentStatus.isBlank ||
        employmentStatus == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidEmploymentStatus);
      debugPrint("Employment status error");
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.formKey.currentState!.validate()) {
      final selectedLoan = ref.watch(selectedLoanApplicationProvider);
      if (selectedLoan != null) {
        updateLoanApplication(context, LoanStatus.initiated.jsonString);
      } else {
        applyForLoanStageOne(context);
      }
    }
  }

  void onValidateGuarantorDetails(BuildContext context) {
    final firstName = state.guarantorFirstnameController.text;
    final lastName = state.guarantorLastnameController.text;
    final email = state.guarantorEmailController.text;
    final phoneNumber = state.guarantorPhoneNoController.text;
    final relationship = state.selectedGuarantorRelationship;

    if (firstName.isBlank) {
      state = state.copyWith(error: StringAssets.pleaseEnterName);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (lastName.isBlank) {
      state = state.copyWith(error: StringAssets.pleaseEnterName);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (relationship.isBlank ||
        relationship == StringAssets.selectAnOption ||
        relationship == StringAssets.selectAnOptionCaps) {
      state = state.copyWith(error: StringAssets.invalidInput);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (email.isBlank) {
      state = state.copyWith(error: StringAssets.enterEmailAddress);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (!RegExp(StringRegex.email).hasMatch(email)) {
      state = state.copyWith(error: StringAssets.invalidEmail);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (phoneNumber.isBlank) {
      state = state.copyWith(error: StringAssets.selectValidEducationalStatus);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.formKey.currentState!.validate()) {
      applyForLoanGuarantorDetails(context);
    }
  }

  void onValidateEmploymentDetails(BuildContext context) {
    final employmentStatus = state.selectedEmploymentType;
    final monthlyIncome = state.incomeController.text;
    final name = state.employerNameController.text;
    final employerAddress = state.employerAddressController.text;
    final employerState = state.selectedNigeriaState;
    final employerLga = state.selectedEmployerLga;

    if (employmentStatus.isBlank) {
      state = state.copyWith(error: StringAssets.selectValidEmploymentStatus);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (monthlyIncome.isBlank) {
      state = state.copyWith(error: StringAssets.pleaseEnterValidIncome);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (name.isBlank) {
      state = state.copyWith(error: StringAssets.pleaseEnterName);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (employerAddress.isBlank) {
      state = state.copyWith(error: StringAssets.pleaseEnterValidAddress);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (employerState.isBlank || employerState == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidState);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (employerLga.isBlank || employerLga == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidLga);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.formKey.currentState!.validate()) {
      applyForLoanEmployer(context);
    } else {
      showModalActionError(context: context, errorText: 'Validation error!');
    }
  }

  Future<void> applyForLoanEmployer(BuildContext context) async {
    state = state.copyWith(isLoading: true);

    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    final loanApplication = ref.watch(selectedLoanApplicationProvider) ??
        LoanApplicationResponseData.empty();
    try {
      var loanApplicationRequest = LoanApplicationEmployerRequest(
        section: LoanSection.employer.jsonString,
        loanRefNo: loanApplication.refNo,
        employerName: state.employerNameController.text,
        monthlyIncome: state.incomeController.text,
        employmentStatus: state.selectedEmploymentType!,
        employerState: state.selectedNigeriaState,
        employerStateLga: state.selectedEmployerLga,
      );
      debugPrint("LOAN STAGE 3 REQUEST: $loanApplicationRequest");

      var apiResponse = await RexApi.instance.makeLoanApplicationEmployer(
        authToken: authToken,
        appVersion: ref.read(appVersionProvider),
        request: loanApplicationRequest,
      );
      state =
          state.copyWith(isLoading: false, loanRefNo: apiResponse.data!.refNo);
      context.pop();
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> fetchPublicAgencies(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      var apiResponse = await RexApi.instance.fetchlookupDataByCode(
        authToken: authToken,
        lookupCode: 'AGENCY',
      );
      state = state.copyWith(
          isLoading: false,
          publicAgencyOptions: apiResponse.list.map((e) => e.name).toList());
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> fetchSingleLoanApplication(
      BuildContext context, String loanRefCode) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      var apiResponse = await RexApi.instance.fetchSingleLoanApplication(
        authToken: authToken,
        loanRefCode: loanRefCode,
      );
      state = state.copyWith(isLoading: false);
      ref.read(selectedLoanApplicationProvider.notifier).state =
          apiResponse.data;
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> updateLoanApplication(
    BuildContext context,
    String status,
  ) async {
    debugPrint("updateLoanApplication entered!!");
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      final selectedLoanApplication =
          ref.watch(selectedLoanApplicationProvider) ??
              LoanApplicationResponseData.empty();
      if (status == LoanStatus.initiated.jsonString) {
        var loanApplicationRequest = LoanApplicationInitiatedRequest(
          loanRefNo: ref.watch(selectedLoanRefCodeProvider),
          loanTitle: selectedLoanApplication.loanTitle,
          section: LoanSection.loan.jsonString,
          amountApplied: selectedLoanApplication.amountApplied,
          purpose: state.loanPurpose ?? selectedLoanApplication.purpose!,
          tenor: selectedLoanApplication.tenor!,
          status: status,
          maritalStatus: state.selectedMaritalStatus,
          residentialAddress: state.residentialAddressController.text,
          inResidenceSince: state.selectedDateInAddress,
          noOfDependants: int.tryParse(state.noOfDependantsController.text),
          educationalStatus: state.selectedEducationalStatus,
          employmentStatus: state.selectedEmploymentStatus,
        );
        debugPrint("LOAN STAGE 1 REQUEST: $loanApplicationRequest");

        var apiResponse = await RexApi.instance.updateLoanApplicationInitiated(
          authToken: authToken,
          request: loanApplicationRequest,
        );
        state = state.copyWith(
            isLoading: false, loanRefNo: apiResponse.data!.refNo);
        debugPrint("API LOAN REF: ${apiResponse.data!.refNo}");
        debugPrint("PROVIDER LOAN REF: ${state.loanRefNo}");
        ref.read(selectedLoanRefCodeProvider.notifier).state = state.loanRefNo;
        ref.invalidate(fetchSingleLoanApplicationProvider);
        context.pop();
        return;
      }

      final request = LoanApplicationGeneralRequest(
        loanRefNo: ref.watch(selectedLoanRefCodeProvider) ?? state.loanRefNo,
        status: status,
        reason: '',
      );
      var apiResponse = await RexApi.instance.updateLoanApplicationGeneral(
        authToken: authToken,
        request: request,
      );
      state = state.copyWith(isLoading: false);
      ref.read(selectedLoanApplicationProvider.notifier).state =
          apiResponse.data;
      showSuccessModal(
          context,
          StringAssets.applicationSubmitted,
          StringAssets.applicationSubmittedDesc,
          StringAssets.ok,
          'success_tick', () {
        ref
            .read(loanProductsProvider.notifier)
            .fetchUserLoanApplication(context);
        context.pop();
        context.go(RouteName.dashboardBorrow);
      });
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> acceptApprovedLoan(
    BuildContext context,
    String transactionPin,
  ) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      final refCode = ref.watch(selectedLoanRefCodeProvider);
      debugPrint("ACCEPT LOAN REF CODE: $refCode");

      final request = LoanApplicationGeneralRequest(
        loanRefNo: ref.watch(selectedLoanRefCodeProvider),
        status: "ACCEPTED",
      );
      var apiResponse = await RexApi.instance.updateLoanApplicationAccept(
        authToken: authToken,
        request: request,
        transactionPin: transactionPin,
        deviceId: deviceMeta?.deviceNumber ?? '',
      );

      state = state.copyWith(isLoading: false, loanOfferAccepted: true);
      ref.read(selectedLoanApplicationProvider.notifier).state =
          apiResponse.data;
      ref.read(loanProductsProvider.notifier).fetchUserLoanApplication(context);
      showModalActionSuccess(
        context: context,
        title: StringAssets.loanOfferAccepted,
        subtitle: StringAssets.loanOfferAcceptedDesc,
        onPressed: () {
          context.go(RouteName.dashboardBorrow);
          // ref
          //     .read(loanProductsProvider.notifier)
          //     .fetchUserLoanApplication(context);
          //context.go(RouteName.dashboardBorrow);
        },
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void onValidateGovtAgency(BuildContext context) {
    if (state.selectedNigeriaState.isBlank ||
        state.selectedNigeriaState == StringAssets.selectAnOption) {
      showModalActionError(
          context: context, errorText: 'Please select a valid state');
      return;
    }
    if (state.selectedAgency.isBlank ||
        state.selectedAgency == StringAssets.selectAnOption) {
      showModalActionError(
          context: context, errorText: 'Please select a valid agency');
      return;
    }
    context.push('${RouteName.dashboardBorrow}/${RouteName.individualBorrow}');
  }

  void updateError() {
    state = state.copyWith(error: '');
  }

  void fetchCompanySectorOptions(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      var apiResponse = await RexApi.instance.fetchlookupDataByCode(
        authToken: authToken,
        entityCode: ref.watch(userEntityCodeProvider),
        lookupCode: 'COMPANY_SECTOR',
      );
      state = state.copyWith(
          isLoading: false,
          companyIndustries: apiResponse.list.map((e) => e.name).toList());
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void onAcceptLoanOffer(BuildContext context) {
    showConfirmPinModalSheet(
        context: context,
        title: StringAssets.acceptLoanOffer,
        subtitle: StringAssets.acceptLoanOfferTranPinDesc,
        onPinEntered: (pin) {
          context.pop();
          acceptApprovedLoan(context, pin);
        });
  }

  void onDeclineLoanOffer(BuildContext context) {
    showModalDeclineLoan(
      context: context,
      onPressed: () {
        context.pop();
        declineApprovedLoan(context);
      },
      textController: state.loanDeclineReasonController,
    );
  }

  Future<void> declineApprovedLoan(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      final request = LoanApplicationGeneralRequest(
          loanRefNo: ref.watch(selectedLoanRefCodeProvider),
          reason: state.loanDeclineReasonController.text,
          status: LoanStatus.declined.jsonString);
      var apiResponse = await RexApi.instance
          .updateLoanApplicationGeneral(authToken: authToken, request: request);
      state = state.copyWith(isLoading: false, loanOfferAccepted: true);
      ref.read(selectedLoanApplicationProvider.notifier).state =
          apiResponse.data;
      ref.read(loanProductsProvider.notifier).fetchUserLoanApplication(context);

      showModalActionSuccess(
        context: context,
        title: StringAssets.loanOfferDeclined,
        subtitle: StringAssets.loanOfferDeclinedDesc,
        onPressed: () {
          context.go(RouteName.dashboardBorrow);
        },
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }
}
