// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/states/individual_loan_calculation_screen_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final loanCalculationProvider = StateNotifierProvider<LoanCalculationNotifier,
    IndividualLoanCalculationScreenState>((ref) {
  var authToken = ref.watch(userAuthTokenProvider) ?? '';
  return LoanCalculationNotifier(authToken, ref);
});

class LoanCalculationNotifier
    extends StateNotifier<IndividualLoanCalculationScreenState>
    with LocatorMix {
  LoanCalculationNotifier(this.authToken, this.ref)
      : super(IndividualLoanCalculationScreenState.initial());

  final String authToken;
  final StateNotifierProviderRef ref;

  void setSelectedTenor(String tenor) {
    state = state.copyWith(selectedTenor: tenor);
  }

  void setLoanPurpose(String purpose) {
    state = state.copyWith(loanPurpose: purpose);
  }

  void validateLoanAmount(BuildContext context, num minAmount, num maxAmount) {
    final loanAmount = state.loanAmountController.text;
    final selectedTenor = state.selectedTenor;

    if (selectedTenor.isBlank || selectedTenor == 'Select an option') {
      state = state.copyWith(error: StringAssets.invalidTenor);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (loanAmount.isBlank) {
      state = state.copyWith(error: StringAssets.invalidAmount);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (minAmount > num.parse(loanAmount)) {
      state = state.copyWith(
          error: StringAssets.loanAmountShouldNotBeLess(minAmount.toString()));
      showModalActionError(context: context, errorText: state.error!);
      return;
    }
    if (num.parse(loanAmount) > maxAmount) {
      state = state.copyWith(
          error: StringAssets.loanAmountShouldNotBeMore(maxAmount.toString()));
      showModalActionError(context: context, errorText: state.error!);
      return;
    }
    calculateLoanRepayment(context);
    return;
  }

  Future<void> calculateLoanRepayment(
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      var loanProductCode = ref.watch(selectedLoanProductProvider)!.productCode;

      var computeLoanRequest = ComputeLoanRequest(
        loanAmount: num.parse(state.loanAmountController.text),
        loanProductCode: loanProductCode,
        tenor: double.parse(state.selectedTenor).toInt(),
        startDate: "",
      );

      var apiResponse = await RexApi.instance.computeLoan(
        authToken: authToken,
        request: computeLoanRequest,
      );
      state = state.copyWith(isLoading: false, computedLoan: apiResponse.data);
      debugPrint("API RESPONSE COMPUTE LOAN: ${apiResponse.data}");
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      debugPrint("API RESPONSE COMPUTE LOAN ERROR: $error");
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  ///This function allows me to reset the error field after it has been shown to
  ///the User so it does not pop up automatically when user retries
  void updateApiError() {
    state = state.copyWith(error: '');
  }

  void onNavigate(BuildContext context, num minAmount, num maxAmount) {
    final loanAmount = state.loanAmountController.text;
    final selectedTenor = state.selectedTenor;

    if (selectedTenor.isBlank) {
      state = state.copyWith(error: StringAssets.invalidTenor);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (loanAmount.isBlank) {
      state = state.copyWith(error: StringAssets.invalidAmount);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (minAmount > num.parse(loanAmount)) {
      debugPrint(
          "Minimum amount $minAmount is greater than ${num.parse(loanAmount)}: ${minAmount > num.parse(loanAmount)}");
      state = state.copyWith(
          error: StringAssets.loanAmountShouldNotBeLess(minAmount.toString()));
      showModalActionError(context: context, errorText: state.error!);
      return;
    }
    if (num.parse(loanAmount) > maxAmount) {
      state = state.copyWith(
          error: StringAssets.loanAmountShouldNotBeMore(maxAmount.toString()));
      showModalActionError(context: context, errorText: state.error!);
      return;
    }
    if (state.loanPurpose == null || state.loanPurpose.isBlank) {
      state = state.copyWith(error: StringAssets.loanPurposeError);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }
    if (state.computedLoan == null) {
      state = state.copyWith(error: StringAssets.loanNotComputed);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }
    ref
        .read(loanApplicationProvider.notifier)
        .setComputedLoan(state.computedLoan!);
    context.push(
        '${Routes.dashboardBorrow}/${Routes.individualLoanDocumentation}');
  }
}
