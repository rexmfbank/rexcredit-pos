// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/utils/enums/app_menu_type.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_error_dialog.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

import '../../../../utils/constants/string_assets.dart';
import '../../../shared/providers/app_preference_provider.dart';
import 'bill_payment_screen_state.dart';

final billPaymentProvider =
    StateNotifierProvider<BillPaymentNotifier, BillPaymentScreenState>((ref) {
      var authToken = ref.watch(appAuthTokenProvider) ?? '';
      return BillPaymentNotifier(authToken, ref);
    });

class BillPaymentNotifier extends StateNotifier<BillPaymentScreenState>
    with AppActionsMixin {
  BillPaymentNotifier(this.authToken, this.ref)
    : super(BillPaymentScreenState.initial());

  final String authToken;
  final StateNotifierProviderRef<BillPaymentNotifier, BillPaymentScreenState>
  ref;

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
        showModalActionError(context: context, errorText: error.toString());
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
      var apiResponse = await RexApi.instance.fetchBillers(
        authToken: authToken,
        query: billerQuery,
      );
      state = state.copyWith(
        isLoading: false,
        electricityBillers: apiResponse.data,
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
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
            );
            break;
          }
        case BillerCategories.data:
          {
            var billers =
                apiResponse.data.billers
                    ?.where((e) => e.products?.isNotEmpty == true)
                    .toList();
            state = state.copyWith(isLoading: false, dataBillers: billers);
            break;
          }
        case BillerCategories.cable:
          {
            var billers =
                apiResponse.data.billers
                    ?.where((e) => e.products?.isNotEmpty == true)
                    .toList();

            state = state.copyWith(isLoading: false, cableBillers: billers);
            break;
          }
        case BillerCategories.education:
          {
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
      print("Error: $error");
      state = state.copyWith(isLoading: false, error: error.toString());
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
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

      final filteredList =
          state.electricityBillers?.billers!.where((services) {
            final service = services.billerName?.toLowerCase();
            final input = query.toLowerCase();

            return service?.contains(input) == true;
          }).toList();

      state = state.copyWith(electricBillers: filteredList);
    }
  }

  void beneficiaryNavigation({
    required TransactionCodes tran,
    required BeneficiaryData data,
  }) {
    if (tran == TransactionCodes.topUp) {
      // ref.read(airtimeProvider.notifier).fillBeneficiaryInfo(
      //       phone: data.beneficiaryAccount ?? '',
      //       billerCode: data.finEntityCode ?? '',
      //     );
      return;
    }

    if (tran == TransactionCodes.data) {
      // ref.read(billPaymentDataProvider.notifier).fillBeneficiaryInfo(
      //       phone: data.beneficiaryAccount ?? '',
      //       billerCode: data.finEntityCode ?? '',
      //     );
      // ref
      //     .read(billPaymentDataProvider.notifier)
      //     .setSelectedDataBeneficiary(data.finEntityName ?? "");
      return;
    }

    if (tran == TransactionCodes.power) {
      // ref.read(electricityProvider.notifier).fillBeneficiaryInfo(
      //       meterNumber: data.beneficiaryAccount ?? '',
      //       billerCode: data.finEntityCode ?? '',
      //     );

      // ref
      //     .read(electricityProvider.notifier)
      //     .setSelectedPowertBeneficiary(data.finEntityName ?? "");
      return;
    }

    if (tran == TransactionCodes.cable) {
      // ref.read(cableTvProvider.notifier).fillBeneficiaryInfo(
      //       cardNumber: data.beneficiaryAccount ?? '',
      //       billerCode: data.finEntityCode ?? '',
      //     );

      // ref
      //     .read(cableTvProvider.notifier)
      //     .setSelectedCableBeneficiary(data.finEntityName ?? "");
      return;
    }
  }

  void onNavigate(BuildContext context, BillerCategories? billerCategory) {
    switch (billerCategory) {
      case BillerCategories.airtime:
        {
          !featureEnabledCheck(
                context: context,
                feature: (ref
                            .watch(loginProvider)
                            .loginResponse
                            .value
                            ?.data
                            .appMenu ??
                        [])
                    .firstWhere(
                      (element) =>
                          (element.menuCode?.jsonString ?? '') ==
                          AppMenuType.airtime.jsonString,
                    ),
              )
              ? null
              : context.push('${Routes.dashboardSpend}/${Routes.billAirtime}');
          break;
        }
      case BillerCategories.data:
        {
          !featureEnabledCheck(
                context: context,
                feature: (ref
                            .watch(loginProvider)
                            .loginResponse
                            .value
                            ?.data
                            .appMenu ??
                        [])
                    .firstWhere(
                      (element) =>
                          (element.menuCode?.jsonString ?? '') ==
                          AppMenuType.data.jsonString,
                    ),
              )
              ? null
              : context.push('${Routes.dashboardSpend}/${Routes.billData}');
          break;
        }
      case BillerCategories.cable:
        {
          !featureEnabledCheck(
                context: context,
                feature: (ref
                            .watch(loginProvider)
                            .loginResponse
                            .value
                            ?.data
                            .appMenu ??
                        [])
                    .firstWhere(
                      (element) =>
                          (element.menuCode?.jsonString ?? '') ==
                          AppMenuType.cable.jsonString,
                    ),
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
                feature: (ref
                            .watch(loginProvider)
                            .loginResponse
                            .value
                            ?.data
                            .appMenu ??
                        [])
                    .firstWhere(
                      (element) =>
                          (element.menuCode?.jsonString ?? '') ==
                          AppMenuType.electricity.jsonString,
                    ),
              )
              ? null
              : context.push(
                '${Routes.dashboardSpend}/${Routes.billElectricity}',
              );
          break;
        }
      default:
        {
          context.showSnackBar(message: StringAssets.notCurrentlySupported);
        }
    }
  }

  Future<void> fetchBeneficiaries(BuildContext context, String tranCode) async {
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

  Future<void> deleteBeneficiaries(
    BuildContext context,
    String tranCode,
    String beneficiaryId, {
    required VoidCallback onSuccess,
  }) async {
    print('Beneficiary ID: $beneficiaryId');
    LoadingScreen.instance().show(context: context);
    state = state.copyWith(isLoading: true);
    try {
      final profileData = ref.watch(loginProvider).loginResponse.value?.data;
      var _ = await RexApi.instance.deleteBeneficiariarie(
        authToken: authToken,
        accountNo: profileData?.primaryAccountNo ?? '',
        transCode: tranCode,
        beneficiaryId: beneficiaryId,
      );

      fetchBeneficiaries(context, tranCode);
      //ref.invalidate(fetchBeneficiaryProvider);
      onSuccess();
      LoadingScreen.instance().hide();
    } catch (error, _) {
      LoadingScreen.instance().hide();
      state = state.copyWith(isLoading: false, error: error.toString());
      showRexErrorDialog(context: context, errorText: error.toString());
    }
  }

  Future<void> searchBeneficiaries({
    required BuildContext context,
    required String query,
  }) async {
    state = state.copyWith(isLoading: true, beneficiaries: []);
    try {
      var apiResponse = await RexApi.instance.searchBeneficiaries(
        authToken: authToken,
        query: SearchBeneficiaryQuery(
          name: query,
          accountNumber:
              ref
                  .read(loginProvider)
                  .loginResponse
                  .value
                  ?.data
                  .primaryAccountNo ??
              '',
        ),
      );
      state = state.copyWith(isLoading: false, beneficiaries: apiResponse.data);
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

  void popUp(BuildContext context) {
    final profileData = ref.watch(loginProvider).loginResponse.value?.data;
    context.go(Routes.dashboardSpend);

    Timer(
      const Duration(seconds: 2),
      () => ref.refresh(userAcctBalanceProvider),
    );
  }
}

final billProvider = FutureProvider.family<BillersResponse, BillerQuery>((
  ref,
  billerQuery,
) async {
  var authToken = ref.watch(appAuthTokenProvider) ?? '';
  return await RexApi.instance.fetchAllBillers(
    authToken: authToken,
    query: billerQuery,
  );
});
