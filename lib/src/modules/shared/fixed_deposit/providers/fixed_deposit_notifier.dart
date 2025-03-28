// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/deposit_providers.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/models/fixed_deposit_state.dart';
import 'package:rex_app/src/modules/shared/target_savings/models/funding_source.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/analytics/analytics_event.dart';
import 'package:rex_app/src/utils/analytics/analytics_service.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final fixedDepositProvider =
    AutoDisposeNotifierProvider<FixedDepositNotifier, FixedDepositState>(
  () => FixedDepositNotifier(),
);

class FixedDepositNotifier extends AutoDisposeNotifier<FixedDepositState>
    with LocatorMix {
  DeviceMetaData? meta;

  @override
  FixedDepositState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    //
    return FixedDepositState(
      fundingSource: '',
      fundingSourceId: '',
      cardPaymentUrl: '',
      cardPaymentReference: '',
      cardCallbackUrl: '',
      planNameController: TextEditingController(),
      amountController: TextEditingController(),
      depositInterestTypeData: const DepositInterestTypeData.empty(),
      isLoadingSavingsReturn: false,
      depositInterestRateData: const DepositInterestRateData.empty(),
      durationSliderValue: 1.0,
      durationTime: '',
      transactionPin: '',
    );
  }

  void onInterestDropdownChange(DepositInterestTypeData? value) {
    state = state.copyWith(depositInterestTypeData: value!);
  }

  void onDurationDropdownChange(String? value) {
    state = state.copyWith(durationTime: value);
  }

  void setDepositDuration(String value) {
    state = state.copyWith(durationTime: value);
  }

  void setTransactionPin(String value) {
    state = state.copyWith(transactionPin: value);
  }

  bool _checkForEmptyFields() {
    return state.amountController.text.isEmpty ||
        state.planNameController.text.isEmpty ||
        state.durationTime.isEmpty ||
        state.depositInterestTypeData.interestType == null;
  }

  bool _isAmountGreater() {
    final amount = state.amountController.text.replaceAll(',', '');
    int invest = int.tryParse(amount) ?? 0;
    if (invest < 100000) return false;
    return true;
  }

  bool _isBalanceSufficient() {
    double? deposit =
        double.tryParse(state.amountController.text.replaceAll(',', ''));
    final balanceEnquiry = ref.watch(userAcctBalanceProvider).asData?.value;
    if (balanceEnquiry == null || deposit == null) {
      return false;
    } else if (deposit > balanceEnquiry.data!.availableBalance) {
      return false;
    } else {
      return true;
    }
  }

  void createDepositForm(BuildContext context) {
    if (_checkForEmptyFields()) {
      showModalActionError(
        context: context,
        title: StringAssets.validationError2,
        errorText: StringAssets.pleaseFillAllFields,
      );
    } else if (!_isAmountGreater()) {
      showModalActionError(
        context: context,
        title: StringAssets.invalidAmount,
        errorText: StringAssets.invalidAmount2,
      );
      return;
    } else if (!_isBalanceSufficient()) {
      showModalActionError(
        context: context,
        title: StringAssets.insufficientAcct,
        errorText: StringAssets.insufficientAccountBalance,
      );
      return;
    } else {
      _calculateRate(context);
    }
  }

  void setFundingByAccount(BuildContext context) {
    final accountNumber = ref.watch(userNubanProvider);
    state = state.copyWith(
      fundingSource: FundingSource.account.name,
      fundingSourceId: accountNumber,
    );
    createFixedDeposit(context);
  }

  Future<void> createFixedDeposit(BuildContext context) async {
    final authToken = ref.watch(userAuthTokenProvider);
    final isBusiness = ref.watch(userIsBusinessProvider);
    final amount = state.amountController.text.replaceAll(',', '');
    Position? position = await getCurrentPosition(context);
    //
    final request = CreateDepositRequest(
      amount: amount,
      duration: state.durationTime,
      planName: state.planNameController.text,
      interestType: state.depositInterestTypeData.interestType,
      fundingSource: state.fundingSource,
      fundingSourceId: state.fundingSourceId,
      geoLocation: "${position?.latitude},${position?.longitude}",
      externalRefNo: AppConstants.guid(),
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.depositCreation(
        authToken: authToken ?? '',
        appVersion: ref.read(appVersionProvider),
        request: request,
        transactionPin: state.transactionPin,
        deviceId: meta?.deviceNumber ?? '',
      );
      LoadingScreen.instance().hide();
      ref.invalidate(fetchFixedDepositList);
      ref.invalidate(fetchFixedDepositWalletBalance);
      AnalyticsService.instance.logEvent(name: AnalyticsEvent.createDeposit);
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: 'Fixed deposit has been created',
          onPressed: () {
            if (isBusiness) {
              context.go(RouteName.dashboardSaveBusiness);
            } else {
              context.go(RouteName.dashboardSave);
            }
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

  Future<void> _calculateRate(BuildContext context) async {
    final authToken = ref.watch(userAuthTokenProvider);
    final isBusiness = ref.watch(userIsBusinessProvider);
    final amount = state.amountController.text.replaceAll(',', '');
    //
    final request = DepositInterestRateRequest(
      amount: amount,
      duration: state.durationTime.getDepositDuration(),
      interestType: state.depositInterestTypeData.interestType,
    );
    state = state.copyWith(isLoadingSavingsReturn: true);
    try {
      final res = await RexApi.instance.depositInterestRate(
        authToken: authToken ?? '',
        appVersion: ref.read(appVersionProvider),
        deviceId: meta?.deviceNumber ?? '',
        request: request,
      );
      state = state.copyWith(
        depositInterestRateData: res.data,
        isLoadingSavingsReturn: false,
      );
      if (context.mounted) {
        if (isBusiness) {
          context.push(
              "${RouteName.dashboardSaveBusiness}/${RouteName.bizFixedDepositSummary}");
        } else {
          context.push(
              "${RouteName.dashboardSave}/${RouteName.individualFixedDepositSummary}");
        }
      }
    } catch (error) {
      state = state.copyWith(isLoadingSavingsReturn: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  /// FOR CARDS WITH SAVINGS
  void addDebitCard(DebitCardData debitCard) {
    if (debitCard.isSelected) {
      state = state.copyWith(debitCard: debitCard, isCardSelected: true);
    } else {
      state = state.copyWith(debitCard: null, isCardSelected: false);
    }
  }

  void getListOfSavedCards() async {
    final authToken = ref.watch(userAuthTokenProvider);
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
    final authToken = ref.watch(userAuthTokenProvider);
    final isBusiness = ref.watch(userIsBusinessProvider);
    //
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
        if (isBusiness) {
          context.push(
              "${RouteName.dashboardSaveBusiness}/${RouteName.bizFixedDepositWebview}");
        } else {
          context.push(
            "${RouteName.dashboardSave}/${RouteName.individualFixedDepositWebview}",
          );
        }
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
    final authToken = ref.watch(userAuthTokenProvider);
    state = state.copyWith(isLoadingCardVerify: true);
    try {
      final res = await RexApi.instance.cardVerification(
        authToken: authToken ?? '',
        appVersion: ref.read(appVersionProvider),
        request: CardVerifyRequest(
          reference: state.cardPaymentReference,
        ),
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

  void validateFundDepositByCard(BuildContext context) {
    if (state.isCardSelected && state.debitCard != null) {
      state = state.copyWith(
        fundingSource: FundingSource.card.name,
        fundingSourceId: "${state.debitCard!.id}",
      );
      createFixedDeposit(context);
      return;
    } else {
      showModalActionError(
        context: context,
        title: StringAssets.validationError,
        errorText: StringAssets.noCardSelected,
      );
      return;
    }
  }
}
