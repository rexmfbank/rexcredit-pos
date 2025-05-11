// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/target_savings/models/target_saving_state.dart';
import 'package:rex_app/src/modules/shared/target_savings/models/funding_source.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/savings_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/analytics/analytics_event.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final targetSavingProvider =
    AutoDisposeNotifierProvider<TargetSavingNotifier, TargetSavingState>(
  () => TargetSavingNotifier(),
);

class TargetSavingNotifier extends AutoDisposeNotifier<TargetSavingState>
    with LocatorMix {
  DeviceMetaData? meta;

  @override
  TargetSavingState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    //
    return TargetSavingState(
      isYesChecked: false,
      autoSave: false,
      isNoChecked: false,
      selectedDate: null,
      sliderValue: 1.0,
      savingFrequency: '',
      fundingSource: '',
      fundingSourceId: '',
      savingsReturn: const SavingsReturnResponseData.empty(),
      isLoadingSavingsReturn: false,
      targetAmountController: TextEditingController(),
      depositAmountController: TextEditingController(),
      planNameController: TextEditingController(),
      recurringAmountController: TextEditingController(),
      topupController: TextEditingController(),
      transactionPin: '',
      durationSliderValue: 1.0,
      durationTime: '',
      topupSavingInputValidation: false,
      topupSavingShowInput: false,
      //
      cardPaymentReference: '',
      cardPaymentUrl: 'https://www.google.com/',
      cardCallbackUrl: null,
    );
  }

  void onChangeSliderValue(double value) {
    state = state.copyWith(sliderValue: value);
  }

  void onChangeDateTime(DateTime? value) {
    state = state.copyWith(selectedDate: value!);
  }

  void setDurationSliderValue(double value) {
    state = state.copyWith(durationSliderValue: value);
  }

  void setTransactionPin(String value) {
    state = state.copyWith(transactionPin: value);
  }

  void setTopupSavingShowInput() {
    state = state.copyWith(topupSavingShowInput: !state.topupSavingShowInput);
  }

  String formatDate() {
    final year = state.selectedDate!.year;
    final month = state.selectedDate!.month.toString().padLeft(2, '0');
    final day = state.selectedDate!.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  void setFundingByAccount(BuildContext context) {
    final accountNumber = ref.watch(userNubanProvider);
    state = state.copyWith(
      fundingSource: FundingSource.account.name,
      fundingSourceId: accountNumber,
    );
    createTargetSavings(context);
  }

  void setTopupSavingInputValidation(bool value) {
    state = state.copyWith(topupSavingInputValidation: value);
  }

  bool validateTopupSavingInput() {
    final amount = state.topupController.text.replaceAll(',', '');
    if (amount.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void topupSavingByAccount(BuildContext context) {
    final accountNumber = ref.watch(userNubanProvider);
    state = state.copyWith(
      fundingSource: FundingSource.account.name,
      fundingSourceId: accountNumber,
    );
    topupSavings(context: context);
  }

  void onChangeYesCheck(bool? value) {
    state = state.copyWith(
      isYesChecked: value,
      autoSave: value,
      isNoChecked: !value!,
    );
  }

  void onChangeNoCheck(bool? value) {
    state = state.copyWith(
      isNoChecked: value,
      autoSave: value,
      isYesChecked: !value!,
      selectedDate: null,
    );
  }

  bool _checkForEmptyFieldsIfAutoSaveIsNo() {
    return state.targetAmountController.text.isEmpty ||
        state.depositAmountController.text.isEmpty ||
        state.savingFrequency.isEmpty ||
        state.planNameController.text.isEmpty;
  }

  bool _checkForEmptyFieldsIfAutoSaveIsYes() {
    if (state.isNoChecked != null && state.isNoChecked!) {
      return false;
    }
    return state.targetAmountController.text.isEmpty ||
        state.depositAmountController.text.isEmpty ||
        state.planNameController.text.isEmpty ||
        state.savingFrequency.isEmpty;
  }

  bool _isAmountGreater() {
    final dAmount = state.depositAmountController.text.replaceAll(',', '');
    final rAmount = state.recurringAmountController.text.replaceAll(',', '');
    final tAmount = state.targetAmountController.text.replaceAll(',', '');
    //
    int deposit = int.tryParse(dAmount) ?? 0;
    int recurring = int.tryParse(rAmount) ?? 0;
    num target = num.tryParse(tAmount) ?? 0;
    //
    if (state.isNoChecked != null && state.isNoChecked!) {
      if (deposit < 1000 || target < 1000.0) return false;
    } else if (deposit < 1000 || target < 1000.0 || recurring < 1000) {
      return false;
    }
    return true;
  }

  bool _isBalanceSufficient() {
    double? deposit =
        double.tryParse(state.depositAmountController.text.replaceAll(',', ''));
    final balanceEnquiry = ref.watch(userAcctBalanceProvider).asData?.value;
    if (balanceEnquiry == null || deposit == null) {
      return false;
    } else if (deposit > balanceEnquiry.data!.availableBalance) {
      return false;
    } else {
      return true;
    }
  }

  void setSavingFrequency(String? value) {
    state = state.copyWith(savingFrequency: value);
  }

  String _getMaturityDate() {
    final days = 30 * state.durationSliderValue.round();
    final date = DateTime.now();
    final futureDate = date.add(Duration(days: days));
    return futureDate.dateYYYYMMDD();
  }

  void createSavingsForm(BuildContext context) {
    if (_checkForEmptyFieldsIfAutoSaveIsNo()) {
      showModalActionError(
        context: context,
        title: StringAssets.validationError2,
        errorText: StringAssets.pleaseFillAllFields,
      );
    } else if (_checkForEmptyFieldsIfAutoSaveIsYes()) {
      showModalActionError(
        context: context,
        title: StringAssets.validationError2,
        errorText: StringAssets.pleaseFillAllFields,
      );
      return;
    } else if (!_isAmountGreater()) {
      showModalActionError(
        context: context,
        title: StringAssets.invalidAmount,
        errorText: StringAssets.invalidAmount1,
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
      calculateSavingsReturn(context);
    }
  }

  Future<void> createTargetSavings(BuildContext context) async {
    final authToken = ref.watch(userAuthTokenProvider);
    final isBusiness = ref.watch(userIsBusinessProvider);
    //
    final targetAmount = state.targetAmountController.text.replaceAll(',', '');
    final depositAmount =
        state.depositAmountController.text.replaceAll(',', '');
    final recurringAmount =
        state.recurringAmountController.text.replaceAll(',', '');
    Position? position = await getCurrentPosition(context);
    //
    final request = CreateSavingRequest(
      maturityDate: _getMaturityDate(),
      planName: state.planNameController.text,
      targetAmount: num.parse(targetAmount),
      frequency: state.savingFrequency,
      currency: 'NGN',
      autoSave: state.isYesChecked! ? 'Y' : 'N',
      fundingSource: state.fundingSource,
      fundingSourceId: state.fundingSourceId,
      amount: num.parse(depositAmount),
      recurringAmount:
          state.autoSave ? num.tryParse(recurringAmount) ?? 0.0 : 0,
      autoStartDate: state.selectedDate?.dateYYYYMMDD() ?? '',
      geoLocation: "${position?.latitude},${position?.longitude}",
      externalRefNo: AppConstants.guid(),
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.createTargetSavings(
        authToken: authToken ?? '',
        request: request,
        transactionPin: state.transactionPin,
        deviceId: meta?.deviceNumber ?? '',
      );
      LoadingScreen.instance().hide();
      ref.invalidate(fetchSavingsListProvider);
      ref.invalidate(fetchSavingsTransaction(
        const SavingsTranParam(pageNumber: 1, pageSize: 30),
      ));
      ref.invalidate(fetchSavingsWalletBalance);
      if (context.mounted) {
        if (isBusiness) {
          context.go(RouteName.dashboardSaveBusiness);
        } else {
          context.go(RouteName.dashboardSave);
        }
      }
    } catch (error) {
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }

  Future<void> topupSavings({
    required BuildContext context,
  }) async {
    final authToken = ref.watch(userAuthTokenProvider);
    final isBusiness = ref.watch(userIsBusinessProvider);
    final targetSavingsData = ref.watch(inMemoryTargetSavingData);
    final topupAmount = state.topupController.text.replaceAll(',', '');
    Position? position = await getCurrentPosition(context);
    //
    final request = FundSavingRequest(
      fundingScource: state.fundingSource,
      fundingSourceId: state.fundingSourceId,
      amount: num.parse(topupAmount),
      geoLocation: "${position?.latitude},${position?.longitude}",
      externalRefNo: AppConstants.guid(),
    );
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.fundTargetSavings(
        authToken: authToken ?? '',
        deviceId: meta?.deviceNumber ?? '',
        savingId: targetSavingsData.id, //state.topupSavingId,
        request: request,
      );
      LoadingScreen.instance().hide();
      ref.invalidate(fetchSavingsListProvider);
      ref.invalidate(fetchSavingsTransaction(
        const SavingsTranParam(pageNumber: 1, pageSize: 30),
      ));
      ref.invalidate(fetchSavingsWalletBalance);
      ref.invalidate(userAcctBalanceProvider);
      if (context.mounted) {
        if (isBusiness) {
          context.go(RouteName.dashboardSaveBusiness);
        } else {
          context.go(RouteName.dashboardSave);
        }
      }
    } catch (error) {
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }

  Future<void> calculateSavingsReturn(BuildContext context) async {
    final authToken = ref.watch(userAuthTokenProvider);
    final isBusiness = ref.watch(userIsBusinessProvider);
    final targetAmount = state.targetAmountController.text.replaceAll(',', '');
    final recurringAmount =
        state.recurringAmountController.text.replaceAll(',', '');
    //
    final request = SavingsReturnRequest(
      maturityDate: _getMaturityDate(),
      targetAmount: num.tryParse(targetAmount) ?? 0.0,
      autoSave: state.isYesChecked! ? 'Y' : 'N',
      frequency: state.savingFrequency,
      currency: 'NGN',
      recurringAmount:
          state.autoSave ? num.tryParse(recurringAmount) ?? 0.0 : 0,
    );
    state = state.copyWith(isLoadingSavingsReturn: true);
    try {
      final res = await RexApi.instance.calculateReturn(
        authToken: authToken ?? '',
        deviceId: meta?.deviceNumber ?? '',
        request: request,
      );
      state = state.copyWith(
        savingsReturn: res.data,
        isLoadingSavingsReturn: false,
      );
      if (context.mounted) {
        if (isBusiness) {
          context.push(
              "${RouteName.dashboardSaveBusiness}/${RouteName.bizTargetSavingSummary}");
        } else {
          context.push(
            '${RouteName.dashboardSave}/${RouteName.individualTargetSavingSummary}',
          );
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
              "${RouteName.dashboardSaveBusiness}/${RouteName.bizTargetSavingWebview}");
        } else {
          context.push(
            "${RouteName.dashboardSave}/${RouteName.individualTargetSavingWebview}",
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

  void validateFundSavingByCard(BuildContext context) {
    if (state.isCardSelected && state.debitCard != null) {
      state = state.copyWith(
        fundingSource: FundingSource.card.name,
        fundingSourceId: "${state.debitCard!.id}",
      );
      createTargetSavings(context);
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
