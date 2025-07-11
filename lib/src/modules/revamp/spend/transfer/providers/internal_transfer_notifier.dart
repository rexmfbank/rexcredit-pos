import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/components/transfer_pin_dialog.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/beneficiary_api_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_account_look_up_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/view_models/internal_transfer_model.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final internalTransferNotifier =
    NotifierProvider<InternalTransferNotifier, InternalTransferViewModel>(
  () => InternalTransferNotifier(),
);

final selectedTransferTypeProvider =
    StateProvider<String?>((ref) => StringAssets.transferToRexMFB);

class InternalTransferNotifier extends Notifier<InternalTransferViewModel>
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

  void toggleActionTriggered(bool value) =>
      state = state.copyWith(isSendToNewBeneficiary: value);

  void toggleNewBeneficiary() => state =
      state.copyWith(isSendToNewBeneficiary: !state.isSendToNewBeneficiary);

  void toggleAddBeneficiary(bool value) =>
      state = state.copyWith(addNewBeneficiary: value);

  void updateBeneficiaryInfo(
      {required String name, required String accountNo}) {
    state = state.copyWith(
      beneficiaryName: name,
      beneficiaryAccountNo: accountNo,
      beneficiary: accountNo,
    );
  }

  void validate(BuildContext context) {
    final amount = double.parse(
      state.transferAmountController.text.toString().replaceAll(',', ''),
    );
    final availableBalance =
        ref.read(userAcctBalanceProvider).value?.data?.availableBalance ?? 0.0;
    if (state.transferFormKey.currentState!.validate() &&
        state.transferAmountController.text.isNotBlank) {
      if (state.isSendToNewBeneficiary) {
        if (ref.read(selectedTransferTypeProvider.notifier).state.isNotBlank &&
            state.accountNumberController.text.isNotBlank) {
          if (amount >= availableBalance.toDouble()) {
            showModalActionError(
              title: StringAssets.validationError,
              context: context,
              errorText: StringAssets.insufficientAccountBalance,
            );
            return;
          }
          performTransfer(context);
          return;
        }
        showModalActionError(
          context: context,
          title: StringAssets.validationError,
          errorText: StringAssets.pleaseFillAllFields,
        );
        return;
      }
      if (amount >= availableBalance.toDouble()) {
        showModalActionError(
          context: context,
          title: StringAssets.validationError,
          errorText: StringAssets.insufficientAccountBalance,
        );
        return;
      }
      if (state.beneficiaryAccountNo.isBlank || state.beneficiaryName.isBlank) {
        showModalActionError(
          context: context,
          title: StringAssets.validationError,
          errorText: StringAssets.beneficiaryDetailsError,
        );
        return;
      }
      performTransfer(context);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
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

      // Set the flag to true to prevent further triggering.
      ref.read(internalTransferNotifier.notifier).toggleActionTriggered(true);
    }
  }

  void saveTransactionBeneficiary() {
    ref.read(saveBeneficiaryApiProvider.notifier).saveTransactionBeneficiary(
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
    showTransferPinModalSheet(
      context: context,
      onPinEntered: (pin) async {
        context.pop();
        if (ref.read(userNubanProvider).isBlank) {
          return showModalActionError(
            context: context,
            errorText: StringAssets.accountBalanceError,
          );
        }

        LoadingScreen.instance().show(context: context);
        final Position? location = await getCurrentPosition(context);
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
          geolocation: location != null
              ? "${location.longitude},${location.latitude}"
              : 'LAGOS',
          amount: double.parse(
            state.transferAmountController.text.toString().replaceAll(',', ''),
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
          ref.read(internalTransferProvider.notifier).makeInternalTransfer(
                context: context,
                request: internalTransferRequest,
                transactionPin: pin,
                onSuccess: (value) {
                  ref.read(internalTransferNotifier.notifier).clearFields();
                  Timer(
                    const Duration(seconds: 2),
                    () => ref.refresh(userAcctBalanceProvider),
                  );
                  state.addNewBeneficiary ? saveTransactionBeneficiary() : null;
                },
              );
        }
      },
    );
  }
}
