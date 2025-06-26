import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/data/rex_api/src/utils/enums/app_menu_type.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_airtime/provider/airtime_provider.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_cable/provider/cable_tv_provider.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/provider/data_provider.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/provider/electricity_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

import '../../../../../../config/routes/route_name.dart';
import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../shared/providers/app_preference_provider.dart';
import '../states/bill_payment_screen_state.dart';

final billPaymentProvider =
    StateNotifierProvider<BillPaymentNotifier, BillPaymentScreenState>((ref) {
  var authToken = ref.watch(userAuthTokenProvider) ?? '';
  return BillPaymentNotifier(authToken, ref);
});

class BillPaymentNotifier extends StateNotifier<BillPaymentScreenState>
    with AppActionsMixin {
  BillPaymentNotifier(this.authToken, this.ref)
      : super(BillPaymentScreenState.initial());

  final String authToken;
  final StateNotifierProviderRef<BillPaymentNotifier, BillPaymentScreenState>
      ref;

  void setUpAirTimeTab({required int length, required TickerProvider vsync}) {
    state = state.copyWith(
      airtimeTabController: TabController(length: length, vsync: vsync),
    );
  }

  void setUpDataTab({required int length, required TickerProvider vsync}) {
    state = state.copyWith(
      dataTabController: TabController(length: length, vsync: vsync),
    );
  }

  void setUpElectricityTab(
      {required int length, required TickerProvider vsync}) {
    state = state.copyWith(
      electricityTabController: TabController(length: length, vsync: vsync),
    );
  }

  void setUpCableTab({required int length, required TickerProvider vsync}) {
    state = state.copyWith(
      cableTabController: TabController(length: length, vsync: vsync),
    );
  }

  Future<void> fetchBillerCategories(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final profileData = ref.watch(loginProvider).loginResponse.value?.data;
      final billerCategoryQuery = BillerCategoriesQuery(
        countryCode: 'NG',
        entityCode: profileData?.entityCode,
      );

      var apiResponse = await RexApi.instance.fetchBillerCategories(
        authToken: authToken,
        query: billerCategoryQuery,
      );
      state = state.copyWith(
        isLoading: false,
        billerCategories: apiResponse.data.category,
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  Future<void> fetchBillers(
    BuildContext context,
    String billerCategoryName,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final billerQuery = BillerQuery(name: billerCategoryName);
      var apiResponse = await RexApi.instance
          .fetchBillers(authToken: authToken, query: billerQuery);
      //state = state.copyWith(isLoading: false, billers: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  Future<void> fetchAllBillers(
    BuildContext context,
    BillerCategories billerCategoryName,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final billerQuery = BillerQuery(
        billerCategory: billerCategoryName.jsonString,
      );
      var apiResponse = await RexApi.instance.fetchAllBillers(
        authToken: authToken,
        query: billerQuery,
      );
      switch (billerCategoryName) {
        case BillerCategories.airtime:
          {
            state = state.copyWith(
              isLoading: false,
              airtimeBillers: apiResponse.data,
              //airtimeBillers: apiResponse.data,
            );
            break;
          }
        case BillerCategories.data:
          {
            var billers = apiResponse.data.billers
                ?.where((e) => e.products?.isNotEmpty == true)
                .toList();
            state = state.copyWith(isLoading: false, dataBillers: billers);
            break;
          }
        case BillerCategories.cable:
          {
            var billers = apiResponse.data.billers
                ?.where((e) => e.products?.isNotEmpty == true)
                .toList();
            state = state.copyWith(isLoading: false, cableBillers: billers);
            break;
          }
        case BillerCategories.education:
          {
            //state = state.copyWith(isLoading: false, billers: apiResponse.data);
            break;
          }
        case BillerCategories.electricity:
          {
            state = state.copyWith(
              isLoading: false,
              electricityBillers: apiResponse.data,
              electricBillers: apiResponse.data.billers,
            );
            break;
          }
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  void filterElectricityBillers(String query) {
    if (state.electricityBillers != null &&
        state.electricityBillers?.billers != null &&
        state.electricityBillers!.billers!.isNotEmpty) {
      if (query.isEmpty) {
        state = state.copyWith(
          electricBillers: state.electricityBillers!.billers,
        );
        return;
      }

      final filteredList = state.electricityBillers?.billers!.where((services) {
        final service = services.billerName?.toLowerCase();
        final input = query.toLowerCase();

        return service?.contains(input) == true;
      }).toList();

      state = state.copyWith(
        electricBillers: filteredList,
      );
    }
  }

  void beneficiaryNavigation(
      {required TransactionCodes tran, required BeneficiaryData data}) {
    if (tran == TransactionCodes.topUp) {
      state.airtimeTabController!.animateTo(0);
      ref.read(airtimeProvider.notifier).fillBeneficiaryInfo(
            phone: data.beneficiaryAccount ?? '',
            billerCode: data.finEntityCode ?? '',
          );
      return;
    }

    if (tran == TransactionCodes.data) {
      state.dataTabController!.animateTo(0);
      ref.read(billPaymentDataProvider.notifier).fillBeneficiaryInfo(
            phone: data.beneficiaryAccount ?? '',
            billerCode: data.finEntityCode ?? '',
          );
      return;
    }

    if (tran == TransactionCodes.power) {
      state.electricityTabController!.animateTo(0);
      ref.read(electricityProvider.notifier).fillBeneficiaryInfo(
            meterNumber: data.beneficiaryAccount ?? '',
            billerCode: data.finEntityCode ?? '',
          );
      return;
    }

    if (tran == TransactionCodes.cable) {
      state.cableTabController!.animateTo(0);
      ref.read(cableTvProvider.notifier).fillBeneficiaryInfo(
            cardNumber: data.beneficiaryAccount ?? '',
            billerCode: data.finEntityCode ?? '',
          );
      return;
    }
  }

  void onNavigate(BuildContext context, BillerCategories? billerCategory) {
    switch (billerCategory) {
      case BillerCategories.airtime:
        {
          !featureEnabledCheck(
            context: context,
            feature:
                (ref.watch(loginProvider).loginResponse.value?.data.appMenu ??
                        [])
                    .firstWhere((element) =>
                        (element.menuCode?.jsonString ?? '') ==
                        AppMenuType.airtime.jsonString),
          )
              ? null
              : context.push('${Routes.dashboardSpend}/${Routes.billAirtime}');
          break;
        }
      case BillerCategories.data:
        {
          !featureEnabledCheck(
            context: context,
            feature:
                (ref.watch(loginProvider).loginResponse.value?.data.appMenu ??
                        [])
                    .firstWhere((element) =>
                        (element.menuCode?.jsonString ?? '') ==
                        AppMenuType.data.jsonString),
          )
              ? null
              : context.push('${Routes.dashboardSpend}/${Routes.billData}');
          break;
        }
      case BillerCategories.cable:
        {
          !featureEnabledCheck(
            context: context,
            feature:
                (ref.watch(loginProvider).loginResponse.value?.data.appMenu ??
                        [])
                    .firstWhere((element) =>
                        (element.menuCode?.jsonString ?? '') ==
                        AppMenuType.cable.jsonString),
          )
              ? null
              : context.push('${Routes.dashboardSpend}/${Routes.billCableTv}');
          break;
        }
      case BillerCategories.education:
        {
          context.push('${Routes.dashboardSpend}/${Routes.billEducation}');
          break;
        }
      case BillerCategories.electricity:
        {
          !featureEnabledCheck(
            context: context,
            feature:
                (ref.watch(loginProvider).loginResponse.value?.data.appMenu ??
                        [])
                    .firstWhere((element) =>
                        (element.menuCode?.jsonString ?? '') ==
                        AppMenuType.electricity.jsonString),
          )
              ? null
              : context
                  .push('${Routes.dashboardSpend}/${Routes.billElectricity}');
          break;
        }
      default:
        {
          context.showSnackBar(message: StringAssets.notCurrentlySupported);
        }
    }
  }

  Future<void> fetchBeneficiaries(
    BuildContext context,
    String tranCode,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final profileData = ref.watch(loginProvider).loginResponse.value?.data;
      var apiResponse = await RexApi.instance.fetchTransactionBeneficiaries(
        authToken: authToken,
        accountNo: profileData?.primaryAccountNo ?? '',
        transCode: tranCode,
      );
      state = state.copyWith(isLoading: false, beneficiaries: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> searchBeneficiaries({
    required BuildContext context,
    required String query,
  }) async {
    state = state.copyWith(
      isLoading: true,
      beneficiaries: [],
    );
    try {
      var apiResponse = await RexApi.instance.searchBeneficiaries(
        authToken: authToken,
        query: SearchBeneficiaryQuery(
          name: query,
          accountNumber: ref
                  .read(loginProvider)
                  .loginResponse
                  .value
                  ?.data
                  .primaryAccountNo ??
              '',
        ),
      );
      state = state.copyWith(
        isLoading: false,
        beneficiaries: apiResponse.data,
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  void searchAction(BuildContext context) {
    if (state.searchBeneficiaryController.text.isEmpty) {
      fetchBeneficiaries(
        context,
        TransactionCodes.intraBankTransfer.jsonString,
      );
    }
  }

  Future<void> fetchSavedCards(BuildContext context) async {
    try {
      var apiResponse = await RexApi.instance.cardList(
        authToken: authToken,
        appVersion: ref.read(appVersionProvider),
      );
      state = state.copyWith(isLoading: false, savedCards: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      if (context.mounted) {
        context.showToast(message: error.toString());
      }
    }
  }

  void popUp(BuildContext context) {
    final profileData = ref.watch(loginProvider).loginResponse.value?.data;
    if (profileData?.customerType == acctIndividual) {
      context.go(Routes.dashboardSpend);
    } else {
      context.go(Routes.dashboardSpendBusiness);
    }
    Timer(
      const Duration(seconds: 2),
      () => ref.refresh(userAcctBalanceProvider),
    );
  }
}
