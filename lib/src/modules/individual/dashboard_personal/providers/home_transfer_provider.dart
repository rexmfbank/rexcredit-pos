import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/models/home_transfer_state.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transfer/widgets/select_beneficiary_list.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/providers/beneficiary_api_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_bank_list.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_confirm_pin_modal_sheet.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/transfer_success_bottom_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_bottom_modal_sheet.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/transaction_codes.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

///Welcome page notifier provider
final homeTransferNotifier =
    AutoDisposeNotifierProvider<HomeTransferNotifier, HomeTransferState>(
  () => HomeTransferNotifier(),
);

class HomeTransferNotifier extends AutoDisposeNotifier<HomeTransferState>
    with LocatorMix {
  @override
  HomeTransferState build() => HomeTransferState(
        bankNameController: TextEditingController(),
        accountNumberController: TextEditingController(),
        amountController: TextEditingController(),
        acctNameController: TextEditingController(),
        narrationController: TextEditingController(),
        searchController: TextEditingController(),
        bankSearchController: TextEditingController(),
        formKey: GlobalKey<FormState>(),
        selectedDate: null,
        accountInfo: null,
        transferResponse: null,
        bankList: null,
        accountNameError: null,
        textAccountName: "Account Name",
      );

  void setUpTransferTabController({
    required int length,
    required TickerProvider vsync,
  }) {
    state = state.copyWith(
      transferTabController: TabController(length: length, vsync: vsync),
    );
  }

  void toggleLoadingState(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void toggleSaveBeneficiary() {
    state = state.copyWith(saveBeneficiary: !state.saveBeneficiary);
  }

  void toggleSendToNewBeneficiary() {
    state = state.copyWith(sendToNewBeneficiary: !state.sendToNewBeneficiary);
    if (state.sendToNewBeneficiary) {
      state = state.copyWith(selectedBeneficiary: BeneficiaryData());
    }
  }

  void clearBankSearch() {
    state = state.copyWith(bankSearchController: TextEditingController());
    filterBanks(state.bankSearchController.text);
  }

  void selectBeneficiary({
    required BuildContext context,
    required BeneficiaryData option,
  }) {
    context.pop();
    state = state.copyWith(selectedBeneficiary: option);
  }

  // void showBeneficiaryList(BuildContext context) {
  //   showPlatformBottomSheet(
  //     context: context,
  //     backgroundColor: AppColors.rexWhite,
  //     child: const BeneficiaryList(),
  //   );
  // }

  void showBeneficiaryList2(BuildContext context) {
    showPlatformBottomSheet(
      context: context,
      child: SelectBeneficiaryList(
        onClick: (beneficiaryData) {
          state = state.copyWith(
            selectedBeneficiary: beneficiaryData,
            isBeneficiarySelected: true,
            textAccountName: beneficiaryData.beneficiaryName,
            bankNameController:
                TextEditingController(text: beneficiaryData.finEntityName),
            accountNumberController:
                TextEditingController(text: beneficiaryData.beneficiaryAccount),
          );
          context.pop();
        },
      ),
    );
  }

  void showBankList(BuildContext context) {
    showPlatformBottomSheet(
      context: context,
      backgroundColor: AppColors.rexWhite,
      child: BankList(
        onClick: (value) {
          state = state.copyWith(
            bankCode: value.code,
            bankName: value.name,
            bankSelected: true,
            bankNameController: TextEditingController(text: value.name),
          );
          context.pop();
          clearBankSearch();
        },
      ),
    );
  }

  Future<void> getListOfBanks(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final res = await RexApi.instance
          .getBankList(authToken: ref.read(appAuthTokenProvider) ?? '');
      state = state.copyWith(
        isLoading: false,
        bankList: res,
        banks: res.data,
      );
    } catch (error, stack) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  void updateBankInfo(String value) {
    if (value != 'Select an option') {
      state = state.copyWith(
        bankCode: value.split("//")[1],
        bankName: value.split("//")[0],
        bankSelected: true,
      );
      return;
    }
    state = state.copyWith(
      bankSelected: false,
    );
  }

  void filterBanks(String query) {
    if (state.bankList != null &&
        state.bankList?.data != null &&
        state.bankList!.data!.isNotEmpty) {
      if (query.isEmpty) {
        state = state.copyWith(
          banks: state.bankList?.data,
        );
        return;
      }

      final filteredList = state.bankList?.data!.where((banks) {
        final bank = banks.name?.toLowerCase();
        final input = query.toLowerCase();

        return bank?.contains(input) == true;
      }).toList();

      state = state.copyWith(
        banks: filteredList,
      );
    }
  }

  void callValidate(BuildContext context, String value) {
    if (value.length > 9 && !state.isLoading) {
      validateAcct(context);
    }
  }

  Future<void> validateAcct(BuildContext context) async {
    state = state.copyWith(
      isLoading: true,
      accountValidating: true,
      accountNameError: null,
      textAccountName: "Account Name",
    );
    final authToken = ref.read(appAuthTokenProvider) ?? '';
    try {
      final res = await RexApi.instance.performInterAccountLookUp(
        token: authToken,
        request: AccountLookUpRequest(
          bankCode: state.bankCode,
          accountNumber: state.accountNumberController.text,
          bankName: state.bankName,
        ),
      );
      state = state.copyWith(
        isLoading: false,
        accountValidating: false,
        accountInfo: res,
        acctNameController: TextEditingController(text: res.data?.name ?? ''),
        accountNameError: null,
        textAccountName: res.data?.name,
      );
    } catch (error, _) {
      state = state.copyWith(
        isLoading: false,
        accountValidating: false,
        accountInfo: null,
        textAccountName: "Account Name Unavailable!",
        accountNameError: StringAssets.accountNameUnavailable,
      );
    }
  }

  /*Future<void> fetchBeneficiaries(
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final profileData = ref.watch(loginProvider).loginResponse.value?.data;
      var apiResponse = await RexApi.instance.fetchTransactionBeneficiaries(
        authToken: ref.watch(userAuthTokenProvider) ?? '',
        accountNo: profileData?.primaryAccountNo ?? '',
        transCode: TransactionCodes.interTransfer.jsonString,
      );
      state = state.copyWith(
        isLoading: false,
        mainBeneficiaries: apiResponse.data,
        beneficiaries: apiResponse.data,
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }*/

  Future<void> searchBeneficiaries({
    required BuildContext context,
  }) async {
    state = state.copyWith(
      isSearching: true,
      beneficiaries: [],
    );
    try {
      var apiResponse = await RexApi.instance.searchBeneficiaries(
        authToken: ref.watch(appAuthTokenProvider) ?? '',
        query: SearchBeneficiaryQuery(
          name: state.searchController.text,
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
        isSearching: false,
        beneficiaries: apiResponse.data,
      );
    } catch (error, _) {
      state = state.copyWith(isSearching: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  void searchAction() {
    if (state.searchController.text.isBlank) {
      state = state.copyWith(beneficiaries: state.mainBeneficiaries);
      return;
    }
  }

  void saveTransactionBeneficiary(BuildContext context, String pin) {
    ref.read(saveBeneficiaryApiProvider.notifier).saveTransactionBeneficiary(
          request: SaveBeneficiaryRequest(
            accountNo: ref.watch(userNubanProvider),
            tranCode: TransactionCodes.interTransfer.jsonString,
            beneficiaryAccount: state.accountNumberController.text,
            beneficiaryName: state.acctNameController.text,
            beneficiaryMobile: StringAssets.emptyString,
            createdDate: StringAssets.emptyString,
            createdBy: StringAssets.emptyString,
            entityCode: 'RMB',
            username: ref.watch(usernameProvider),
            finEntityCode: state.bankCode,
            finEntityName: state.bankName,
          ),
          onSuccess: () => makeInterBankTransfer(context, pin),
        );
  }

  void validateTransferCall(BuildContext context) {
    final checkBalance = ref.watch(userAcctBalanceProvider);
    final inputAmount =
        double.tryParse(state.amountController.text.replaceAll(',', '')) ??
            0.00;
    //
    checkBalance.when(
      data: (data) {
        final availableBalance = data.data?.availableBalance ?? 0.0;
        if (inputAmount >= availableBalance) {
          showModalActionError(
            context: context,
            title: "Balance Error",
            errorText: StringAssets.insufficientAccountBalance,
          );
          return;
        } else {
          performPinAction(context);
        }
      },
      error: (error, _) {
        showModalActionError(
          context: context,
          title: "Confirmation error",
          errorText: "Could not confirm account balance",
        );
      },
      loading: () => debugPrint(""),
    );
  }

  void performPinAction(BuildContext context) {
    showConfirmPinModalSheet(
      context: context,
      title: StringAssets.enterPin,
      onPinEntered: (pin) {
        context.pop();
        state = state.copyWith(isLoading: true);
        if (state.saveBeneficiary) {
          saveTransactionBeneficiary(context, pin);
          return;
        }
        makeInterBankTransfer(context, pin);
      },
    );
  }

  Future<void> makeInterBankTransfer(BuildContext context, String pin) async {
    final isBusinessAccount = ref.watch(userIsBusinessProvider);
    final Position? location = await getCurrentPosition(context);
    Random random = Random();
    int num = random.nextInt(999999);
    int num2 = random.nextInt(888888);
    int num3 = random.nextInt(666666);
    String randomNum = "$num$num2$num3";

    try {
      final request = InterBankTransferRequest(
        externalRefNo: randomNum,
        terminalId: '1234567890',
        deviceId:
            ref.watch(deviceMetaProvider).asData?.value.deviceNumber ?? '',
        pin: pin,
        sourceAccount: ref.read(userNubanProvider) ?? '',
        senderName:
            ref.read(loginProvider).loginResponse.value?.data.fullname ?? '',
        beneficiaryAccount: state.isBeneficiarySelected
            ? state.selectedBeneficiary?.beneficiaryAccount ?? ''
            : state.accountNumberController.text,
        beneficiaryName: state.isBeneficiarySelected
            ? state.selectedBeneficiary?.beneficiaryName ?? ''
            : state.acctNameController.text,
        beneficiaryMobile: '',
        beneficiaryBankCode: state.isBeneficiarySelected
            ? state.selectedBeneficiary?.finEntityCode ?? ''
            : state.bankCode,
        beneficiaryAccountType: '',
        entityCode: 'RMB',
        geolocation: location != null
            ? "${location.longitude},${location.latitude}"
            : 'null',
        amount: double.parse(state.amountController.text.replaceAll(',', '')),
        narration: state.narrationController.text,
        username:
            ref.read(loginProvider).loginResponse.value?.data.username ?? '',
        saveBeneficiary: state.saveBeneficiary,
      );
      //
      state = state.copyWith(isLoading: true);
      final response = await RexApi.instance.interBankTransfer(
        authToken: ref.read(appAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = state.copyWith(isLoading: false, transferResponse: response.data);
      if (context.mounted) {
        showTransferSuccessModal(
          context,
          StringAssets.transferSuccessful,
          StringAssets.transferSuccessfulSubtitle(
            amount: state.amountController.text,
            acctName: state.selectedBeneficiary?.beneficiaryName ??
                state.acctNameController.text,
            bankName:
                state.bankName.isNotBlank ? state.bankName : StringAssets.bank,
            accountNumber: state.selectedBeneficiary?.beneficiaryAccount ??
                state.accountNumberController.text,
          ),
          transInfo: response.data ?? TransferData(),
          onPressed: () {
            Timer(
              const Duration(seconds: 2),
              () => ref.refresh(userAcctBalanceProvider),
            );
            if (isBusinessAccount) {
              context.go(Routes.dashboardBusiness);
            } else {
              context.go(Routes.dashboardIndividual);
            }
          },
        );
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }
}

/// standalone providers
// 1. fetch beneficiaries
final fetchBeneficiaryProvider =
    FutureProvider<List<BeneficiaryData>?>((ref) async {
  final apiResponse = await RexApi.instance.fetchTransactionBeneficiaries(
    authToken: ref.watch(appAuthTokenProvider) ?? '',
    accountNo: ref.watch(userNubanProvider) ?? '',
    transCode: TransactionCodes.interTransfer.jsonString,
  );
  return apiResponse.data;
});
