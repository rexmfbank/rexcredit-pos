// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/fetch_single_loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/states/personal_details_application_screen_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/loan_application_section.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final personalDetailsLoanApplicationProvider = NotifierProvider<
        PersonalDetailsLoanApplicationNotifier,
        PersonalDetailsApplicationScreenState>(
    () => PersonalDetailsLoanApplicationNotifier());

class PersonalDetailsLoanApplicationNotifier
    extends Notifier<PersonalDetailsApplicationScreenState> {
  @override
  PersonalDetailsApplicationScreenState build() {
    return PersonalDetailsApplicationScreenState.initial();
  }

  void setSelectedMaritalStatus(String maritalStatus) {
    state = state.copyWith(selectedMaritalStatus: maritalStatus);
  }

  void setSelectedDate(DateTime? selectedDate) {
    selectedDate != null
        ? state = state.copyWith(
            selectedDate:
                '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}')
        : state =
            state.copyWith(selectedMaritalStatus: StringAssets.selectDate);
  }

  void setSelectedEducationalStatus(String status) {
    state = state.copyWith(selectedEducationalStatus: status);
  }

  void setSelectedEmploymentStatus(String status) {
    state = state.copyWith(selectedEmploymentStatus: status);
  }

  Future<void> applyForLoanStageOne(
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    final computedLoan = state.computedLoan ?? ComputeLoanResponseData.empty();
    final loanProduct = ref.watch(selectedLoanProductProvider) ??
        const LoanProductModel.empty();
    debugPrint("LOAN STAGE 1 REQUEST: $computedLoan");
    try {
      var loanApplicationRequest = LoanApplicationStageOneRequest(
        productCode: loanProduct.productCode,
        loanTitle: loanProduct.title,
        section: LoanSection.loan.jsonString,
        amountApplied: computedLoan.amount?.toDouble() ?? 0.0,
        loanRefNo: null,
        purpose: ref.watch(loanApplicationProvider).loanPurpose ?? '',
        tenor: computedLoan.repaymentCount!,
        status: "INITIATED",
        maritalStatus: state.selectedMaritalStatus,
        residentialAddress: state.residentialAddressController.text,
        inResidenceSince: state.selectedDate,
        noOfDependants: int.tryParse(state.noOfDependantsController.text),
        educationalStatus: state.selectedEducationalStatus,
        employmentStatus: state.selectedEmploymentStatus,
      );
      debugPrint("LOAN STAGE 1 REQUEST: $loanApplicationRequest");

      var apiResponse = await RexApi.instance.makeLoanApplicationStageOne(
        authToken: authToken,
        appVersion: ref.read(appVersionProvider),
        request: loanApplicationRequest,
      );
      state = state.copyWith(
        isLoading: false,
        loanRefNo: apiResponse.data!.refNo,
      );
      ref.read(selectedLoanRefCodeProvider.notifier).state = state.loanRefNo;
      ref.invalidate(fetchSingleLoanApplicationProvider);
      context.pop();
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void onValidatePersonalDetails(BuildContext context) {
    final residentialAddress = state.residentialAddressController.text;
    final noOfDependants = state.noOfDependantsController.text;
    final maritalStatus = state.selectedMaritalStatus;
    final timeInAddress = state.selectedDate;
    final educationalStatus = state.selectedEducationalStatus;
    final employmentStatus = state.selectedEmploymentStatus;

    if (maritalStatus.isBlank || maritalStatus == 'Select an option') {
      state = state.copyWith(error: StringAssets.selectValidMaritalStatus);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (residentialAddress.isBlank) {
      state = state.copyWith(error: StringAssets.invalidResidentialAddress);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (timeInAddress.isBlank) {
      state = state.copyWith(error: StringAssets.invalidInput);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (noOfDependants.isBlank) {
      state = state.copyWith(error: StringAssets.invalidNoOfDependants);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (educationalStatus.isBlank || educationalStatus == 'Select an option') {
      state = state.copyWith(error: StringAssets.selectValidEducationalStatus);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (employmentStatus.isBlank || employmentStatus == 'Select an option') {
      state = state.copyWith(error: StringAssets.selectValidEmploymentStatus);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.formKey.currentState!.validate()) {
      applyForLoanStageOne(context);
    }
  }

  void updateError() {
    state = state.copyWith(error: '');
  }
}
