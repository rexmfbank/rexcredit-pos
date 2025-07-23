import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/dashboard/models/dashboard_topup_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final dashboardTopUpProvider =
    AutoDisposeNotifierProvider<DashboardTopUpNotifier, DashboardTopUpState>(
      () => DashboardTopUpNotifier(),
    );

class DashboardTopUpNotifier extends AutoDisposeNotifier<DashboardTopUpState> {
  @override
  DashboardTopUpState build() {
    return DashboardTopUpState(
      amountController: TextEditingController(),
      cardPaymentReference: '',
      cardPaymentUrl: 'https://www.google.com/',
      cardCallbackUrl: null,
    );
  }

  void toggleCardSelected(bool value) =>
      state = state.copyWith(isCardSelected: value);

  void addDebitCard(DebitCardData debitCard) {
    if (debitCard.isSelected) {
      state = state.copyWith(debitCard: debitCard, isCardSelected: true);
    } else {
      state = state.copyWith(debitCard: null, isCardSelected: false);
    }
  }

  void addCardActions(BuildContext context) {
    final amount = state.amountController.text.replaceAll(',', '');
    if (amount.isNotBlank) {
      getListOfSavedCards();
      context.push(
        '${Routes.dashboardIndividual}/${Routes.dashboardSavedCards}',
      );
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.amountNotEmpty,
    );
  }

  void getListOfSavedCards() async {
    final authToken = ref.watch(appAuthTokenProvider);
    state = state.copyWith(cardListResponse: const AsyncValue.loading());
    try {
      final res = await RexApi.instance.cardList(
        authToken: authToken ?? '',
        appVersion: ref.read(appVersionProvider),
      );
      state = state.copyWith(cardListResponse: AsyncValue.data(res));
    } catch (error, stackTrace) {
      state = state.copyWith(
        cardListResponse: AsyncValue.error(error, stackTrace),
      );
    }
  }

  void addNewCard(BuildContext context) async {
    final authToken = ref.watch(appAuthTokenProvider);
    state = state.copyWith(
      isLoading: true,
      cardPaymentResponse: const AsyncValue.loading(),
    );
    try {
      final res = await RexApi.instance.cardInitiatePayment(
        authToken: authToken ?? '',
        appVersion: ref.read(appVersionProvider),
      );
      state = state.copyWith(
        isLoading: false,
        cardPaymentResponse: AsyncValue.data(res),
        cardPaymentReference: res.data.reference,
        cardPaymentUrl: res.data.paymentUrl,
        cardCallbackUrl: res.data.callbackUrl,
      );
      if (context.mounted) {
        context.push(
          "${Routes.dashboardIndividual}/${Routes.dashboardAddCardWebview}",
        );
      }
    } catch (error, stackTrace) {
      state = state.copyWith(
        isLoading: false,
        cardPaymentResponse: AsyncValue.error(error, stackTrace),
      );
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }

  Future<void> verifyCard() async {
    final authToken = ref.watch(appAuthTokenProvider);
    state = state.copyWith(isLoadingCardVerify: true);
    try {
      final res = await RexApi.instance.cardVerification(
        authToken: authToken ?? '',
        appVersion: ref.read(appVersionProvider),
        request: CardVerifyRequest(reference: state.cardPaymentReference),
      );
      state = state.copyWith(
        isLoadingCardVerify: false,
        cardVerifyResponse: res,
      );
    } catch (error) {
      state = state.copyWith(
        isLoadingCardVerify: false,
        cardVerifyResponse: null,
      );
    }
  }

  void validateTopUp(BuildContext context) {
    if (state.isCardSelected && state.debitCard != null) {
      topUpAccount(context);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.noCardSelected,
    );
  }

  Future<void> topUpAccount(BuildContext context) async {
    final authToken = ref.watch(appAuthTokenProvider);
    final amount = state.amountController.text.replaceAll(',', '');
    //
    final request = AccountTopUpRequest(
      cardId: state.debitCard!.id.toString(),
      amount: amount,
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      final res = await RexApi.instance.accountTopUp(
        authToken: authToken ?? '',
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = state.copyWith(topUpResponse: res);
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: StringAssets.topup(
            state.amountController.text.formatCurrencyString(),
          ),
          onPressed: () {
            ref.invalidate(userAcctBalanceProvider);
            context.go(Routes.dashboardIndividual);
          },
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
