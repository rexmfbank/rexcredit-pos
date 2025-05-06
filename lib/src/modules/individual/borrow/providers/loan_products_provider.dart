// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/borrow/states/dashboard_borrow_state.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_error_dialog.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';

final loanProductsProvider =
    StateNotifierProvider<LoanProductsNotifier, DashboardBorrowScreenState>(
        (ref) {
  var authToken = ref.watch(userAuthTokenProvider) ?? '';
  return LoanProductsNotifier(authToken, ref);
});

final selectedLoanProductProvider =
    StateProvider<LoanProductModel?>((ref) => null);

class LoanProductsNotifier extends StateNotifier<DashboardBorrowScreenState> {
  LoanProductsNotifier(this.authToken, this.ref)
      : super(DashboardBorrowScreenState.initial());

  final String authToken;
  final StateNotifierProviderRef<LoanProductsNotifier,
      DashboardBorrowScreenState> ref;

  Future<void> fetchLoanProducts(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final res = await RexApi.instance.getLoanProducts(authToken: authToken);
      state = state.copyWith(isLoading: false, loanProducts: res.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(
        context: context,
        errorText: error.toString(),
      );
    }
  }

  Future<void> fetchSingleLoanProduct(
      BuildContext context, String productCode) async {
    state = state.copyWith(isLoading: true);
    try {
      final res = await RexApi.instance
          .getSingleLoanProduct(authToken: authToken, productCode: productCode);
      state = state.copyWith(isLoading: false, selectedLoanProduct: res.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showCustomErrorDialog(
        context: context,
        errorText: error.toString(),
      );
    }
  }

  Future<void> fetchUserLoanApplication(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse =
          await RexApi.instance.fetchUserLoanApplication(authToken: authToken);
      state = state.copyWith(
          isLoading: false,
          loanApplications: apiResponse.data
              ?.where((element) => ![
                    'COMPLETED',
                    'DECLINED',
                    'REJECTED',
                    'TERMINATED',
                    'CLOSED'
                  ].contains(element.status))
              .toList());
      if (state.loanApplications!.isEmpty) {
        fetchLoanProducts(context);
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showCustomErrorDialog(
        context: context,
        errorText: error.toString(),
      );
    }
  }

  Future<void> fetchLoanPurposeOptions(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.fetchlookupDataByCode(
        authToken: authToken,
        entityCode: ref.watch(userEntityCodeProvider),
        lookupCode: 'LOAN_PURPOSE',
      );
      state = state.copyWith(
          isLoading: false,
          loanPurposeOptions: apiResponse.list.map((e) => e.name).toList());
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }
}
