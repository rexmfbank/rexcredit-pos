import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/states/loan_repayment_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/target_savings/models/funding_source.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final fetchLoanDetailProvider = FutureProvider<LoanDetail?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider) ?? '';
  final api = await RexApi.instance.getLoanDetail(token: authToken);
  return api.data;
});

final inMemoryLoanDetail = StateProvider<LoanDetail>((ref) {
  return const LoanDetail.empty();
});

final loanRepaymentProvider =
    NotifierProvider<LoanRepaymentNotifier, LoanRepaymentState>(
  () => LoanRepaymentNotifier(),
);

class LoanRepaymentNotifier extends Notifier<LoanRepaymentState> {
  @override
  LoanRepaymentState build() {
    return LoanRepaymentState(
      amountController: TextEditingController(),
      fundingSource: '',
      fundingSourceId: '',
      terminateLoan: false,
    );
  }

  void validateLoanTermination(BuildContext context) {
    final accountNumber = ref.watch(userNubanProvider);
    state = state.copyWith(
      terminateLoan: true,
      fundingSource: FundingSource.account.name,
      fundingSourceId: accountNumber,
    );
    loanTermination(context);
  }

  bool validateLoanPartPayment(BuildContext context) {
    if (state.amountController.text.isEmpty) {
      showModalActionError(
        context: context,
        errorText: StringAssets.amountCannotBeBlank,
      );
      return false;
    } else {
      final accountNumber = ref.watch(userNubanProvider);
      state = state.copyWith(
        terminateLoan: false,
        fundingSource: FundingSource.account.name,
        fundingSourceId: accountNumber,
      );
      return true;
    }
  }

  Future<void> loanTermination(BuildContext context) async {
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    final loanDetail = ref.watch(inMemoryLoanDetail);
    //
    final request = LoanRepaymentRequest(
      amount: "${loanDetail.totalOutstanding}",
      note: '',
      fundingSource: state.fundingSource,
      fundingSourceId: state.fundingSourceId,
      terminate: state.terminateLoan,
    );
    LoadingScreen.instance().show(context: context);
    try {
      final api = await RexApi.instance.repayLoan(
        authToken: authToken,
        request: request,
      );
      LoadingScreen.instance().hide();
      ref.read(loanProductsProvider.notifier).fetchUserLoanApplication(context);
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: StringAssets.loanTermination,
          onPressed: () => context.go(Routes.dashboardBorrow),
        );
      }
    } catch (error) {
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }

  Future<void> loanPartPayment(BuildContext context) async {
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    final request = LoanRepaymentRequest(
      amount: state.amountController.text,
      note: '',
      fundingSource: state.fundingSource,
      fundingSourceId: state.fundingSourceId,
      terminate: state.terminateLoan,
    );
    LoadingScreen.instance().show(context: context);
    try {
      final api = await RexApi.instance.repayLoan(
        authToken: authToken,
        request: request,
      );
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: StringAssets.loanRepaymentSuccesful,
          onPressed: () => context.go(Routes.dashboardBorrow),
        );
      }
    } catch (error) {
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }
}
