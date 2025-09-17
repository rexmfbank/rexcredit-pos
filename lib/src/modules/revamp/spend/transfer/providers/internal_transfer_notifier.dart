import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/providers/location_handler.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui_widgets/transfer_pin_dialog.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/beneficiary_api_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_account_look_up_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/model/internal_transfer_model.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/revamp/utils/locator_mixin.dart';

final internalTransferNotifier = AutoDisposeNotifierProvider<
  InternalTransferNotifier,
  InternalTransferViewModel
>(() => InternalTransferNotifier());

final selectedTransferTypeProvider = StateProvider<String?>(
  (ref) => StringAssets.transferToRexMFB,
);

class InternalTransferNotifier
    extends AutoDisposeNotifier<InternalTransferViewModel>
    with LocatorMix {
  @override
  InternalTransferViewModel build() => InternalTransferViewModel(
    transferFormKey: GlobalKey<FormState>(),
    transferAmountController: TextEditingController(),
    accountNumberController: TextEditingController(),
    narrationController: TextEditingController(),
  );

  void clearFields() {
    state.transferAmountController.clear();
    state.accountNumberController.clear();
    state.narrationController.clear();
    state.transferFormKey.currentState!.reset();
  }

  void accountNumberController() {
    state.accountNumberController.clear();
  }

  void toggleBeneficiary() =>
      state = state.copyWith(isSendToBeneficiary: !state.isSendToBeneficiary);

  void toggleAddBeneficiary(bool value) =>
      state = state.copyWith(addNewBeneficiary: value);

  void updateBeneficiaryInfo({
    required String name,
    required String accountNo,
  }) {
    state = state.copyWith(
      beneficiaryName: name,
      beneficiaryAccountNo: accountNo,
      beneficiary: accountNo,
    );
  }

  void clearBeneficiary() {
    state = state.copyWith(
      beneficiaryName: "",
      beneficiaryAccountNo: "",
      beneficiary: "",
    );
  }

  void validate(BuildContext context) {
    // Early validation - check form and basic requirements
    if (!_isFormValid()) {
      _showValidationError(context, StringAssets.pleaseFillAllFields);
      return;
    }

    // Parse amount and get balance
    final amount = state.transferAmountController.text.parseToDoubleSafely();
    final availableBalance =
        ref.watch(userAcctBalanceProvider).value?.data?.availableBalance ?? 0.0;

    // Check insufficient balance early
    if (_hasInsufficientBalance(amount, availableBalance)) {
      _showValidationError(context, StringAssets.insufficientAccountBalance);
      return;
    }

    // Validate based on transfer type
    if (state.beneficiaryName.isEmpty) {
      _validateNewBeneficiaryTransfer(context);
    } else {
      _validateExistingBeneficiaryTransfer(context);
    }
  }

  // Helper methods for cleaner validation logic
  bool _isFormValid() {
    return state.transferFormKey.currentState?.validate() == true &&
        state.transferAmountController.text.isNotBlank;
  }

  bool _hasInsufficientBalance(double amount, double availableBalance) {
    return amount >= availableBalance.toDouble();
  }

  void _validateNewBeneficiaryTransfer(BuildContext context) {
    final hasTransferType =
        ref.read(selectedTransferTypeProvider.notifier).state.isNotBlank;
    final hasAccountNumber = state.accountNumberController.text.isNotBlank;

    if (!hasTransferType || !hasAccountNumber) {
      _showValidationError(context, StringAssets.pleaseFillAllFields);
      return;
    }

    performTransfer(context);
  }

  void _validateExistingBeneficiaryTransfer(BuildContext context) {
    if (state.beneficiaryAccountNo.isBlank || state.beneficiaryName.isBlank) {
      _showValidationError(context, StringAssets.beneficiaryDetailsError);
      return;
    }

    performTransfer(context);
  }

  void _showValidationError(BuildContext context, String errorText) {
    context.showToast(message: errorText);
  }

  void accountNameLookUp() {
    if (ref.watch(selectedTransferTypeProvider) != "" &&
        state.accountNumberController.text.length == 10) {
      // Trigger the accountlookUpNotifier function
      final internalAccountLookupRequest = AccountLookUpRequest(
        bankCode: "RMB",
        accountNumber: state.accountNumberController.text,
      );
      ref
          .read(internalAccountLookUpProvider.notifier)
          .doInternalAccountLookUp(request: internalAccountLookupRequest);
    }
  }

  void saveTransactionBeneficiary() {
    ref
        .read(saveBeneficiaryApiProvider.notifier)
        .saveTransactionBeneficiary(
          request: SaveBeneficiaryRequest(
            accountNo: ref.watch(userNubanProvider),
            tranCode: TransactionCodes.intraBankTransfer.jsonString,
            beneficiaryAccount: state.beneficiaryAccountNo,
            beneficiaryName: state.beneficiaryName,
            beneficiaryMobile: StringAssets.emptyString,
            createdDate: StringAssets.emptyString,
            createdBy: StringAssets.emptyString,
            entityCode: 'RMB',
            username: ref.watch(usernameProvider),
          ),
        );
  }

  void performTransfer(BuildContext context) {
    final location = ref.watch(locationStateProvider);
    showTransferPinModalSheet(
      context: context,
      onPinEntered: (pin) async {
        FocusScope.of(context).unfocus();
        context.pop();
        if (ref.read(userNubanProvider).isBlank) {
          return showModalActionError(
            context: context,
            errorText: StringAssets.accountBalanceError,
          );
        }

        LoadingScreen.instance().show(context: context);

        try {
          final internalTransferRequest = InternalTransferRequest(
            externalRefNo: generateRandomString(),
            terminalId: StringAssets.emptyString,
            deviceId:
                ref.read(deviceMetaProvider).asData?.value.deviceNumber ?? '',
            sourceAccount: ref.watch(userNubanProvider),
            tranCode: TransactionCodes.intraBankTransfer.jsonString,
            senderName: ref.read(userFullNameProvider),
            beneficiaryAccount: state.beneficiaryAccountNo,
            beneficiaryName: state.beneficiaryName,
            beneficiaryMobile: StringAssets.emptyString,
            beneficiaryBankCode: StringAssets.rmb,
            beneficiaryAccountType: StringAssets.emptyString,
            entityCode: 'RMB',
            geolocation:
                location.currentPosition != null
                    ? "${location.currentPosition?.longitude},${location.currentPosition?.latitude}"
                    : '',
            amount: double.parse(
              state.transferAmountController.text.removeCommas(),
            ),
            charge: "0.0",
            currencyCode: "NGN",
            narration: state.narrationController.text.toString(),
            paymentMethod: StringAssets.transferPaymentMethod,
            ufdData: null,
            channelType: "MOBILE",
            network: "",
            username: ref.read(usernameProvider),
            saveBeneficiary: state.addNewBeneficiary,
          );

          LoadingScreen.instance().hide();
          if (context.mounted) {
            ref
                .read(internalTransferProvider.notifier)
                .makeInternalTransfer(
                  context: context,
                  request: internalTransferRequest,
                  transactionPin: pin,
                  onSuccess: (value) async {
                    ref.read(internalTransferNotifier.notifier).clearFields();

                    await Future.delayed(Duration(milliseconds: 700));
                    ref.invalidate(userAcctBalanceProvider);

                    // ref.read(billPaymentProvider.notifier).fetchBeneficiaries(
                    //       getAppContext() ?? context,
                    //       TransactionCodes.intraBankTransfer.jsonString,
                    //     );

                    // showModalActionSuccess(
                    //   context: context,
                    //   subtitle: 'Transaction successful',
                    //   onPressed: () {
                    //
                    //   },
                    // );
                  },
                );
          }
        } catch (e) {
          LoadingScreen.instance().hide();
          showModalActionError(
            // ignore: use_build_context_synchronously
            context: context,
            errorText: 'An unexpected error occurred: ${e.toString()}',
          );
        }
      },
    );
  }
}
