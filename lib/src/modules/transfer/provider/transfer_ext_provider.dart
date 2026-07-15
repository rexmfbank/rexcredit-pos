// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/models/name_inquiry_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_state.dart';
import 'package:rex_app/src/modules/transfer/widgets/bank_list.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_bottom_modal_sheet.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final transferExtProvider =
    AutoDisposeNotifierProvider<TransferExtNotifier, TransferExtState>(
      () => TransferExtNotifier(),
    );

class TransferExtNotifier extends AutoDisposeNotifier<TransferExtState> {
  @override
  TransferExtState build() {
    ref.onDispose(() => _dispose());
    return TransferExtState(
      bankNameController: TextEditingController(),
      accountNumberController: TextEditingController(),
      amountController: TextEditingController(),
      acctNameController: TextEditingController(),
      narrationController: TextEditingController(),
      searchController: TextEditingController(),
      bankSearchController: TextEditingController(),
      isLoading: false,
      fetchingBanks: false,
      bankSelected: false,
      recipientAcctName: '',
      recipientAcctNo: '',
      recipientBankCode: '',
      recipientBankName: '',
      recipientCode: '',
      banksList: [],
    );
  }

  // void callValidate(BuildContext context, String value) {
  //   if (value.length > 9 && !state.isLoading) {
  //     validateAcct(context);
  //   }
  // }

  Future<void> validateAcct(BuildContext context, String value) async {
    if (value.length < 10 && state.isLoading) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final config = AppKeysStorage.getConfig();
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.loginAuthToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    final request = NameInquiryRequest(
      accountNumber: state.accountNumberController.text,
      bankCode: state.recipientBankCode,
      borrowerID: "${config.borrowerID}",
    );
    try {
      final res = await RexApi.instance.nameInquiry(
        header: header,
        request: request,
      );
      state = state.copyWith(
        isLoading: false,
        recipientAcctName: res.accountName,
        recipientBankCode: res.bankCode,
        recipientBankName: res.bankName,
        recipientAcctNo: res.accountNumber,
        recipientCode: res.recipientCode,
      );
    } catch (err, _) {
      state = state.copyWith(isLoading: false);
      debugPrintDev("error on name inquiry:interbank: $err");
    }
  }

  void validateTransferCall(BuildContext context) {}

  Future<void> interbankTransfer(String pin, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final config = AppKeysStorage.getConfig();
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.loginAuthToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    final request = SendMoneyRequest(
      accountNumber: state.accountNumberController.text,
      borrowerId: config.borrowerID,
      amount: state.amountController.text,
      narration: state.narrationController.text,
      recipientCode: state.recipientCode,
      pin: pin,
    );
    try {
      await RexApi.instance.sendMoney(header: header, request: request);
      state = state.copyWith(isLoading: false);
      context.go(Routes.dashboardIndividual);
    } catch (err, _) {
      state = state.copyWith(isLoading: false);
      debugPrintDev('error on send-money:interbank: $err');
    }
  }

  void showBankList(BuildContext context) {
    state = state.copyWith(
      bankNameController: TextEditingController(text: ''),
      accountNumberController: TextEditingController(text: ''),
    );
    showPlatformBottomSheet(
      context: context,
      backgroundColor: AppColors.rexWhite,
      child: BankList(
        onClick: (value) {
          state = state.copyWith(
            recipientBankCode: value.code,
            recipientBankName: value.name,
            bankSelected: true,
            bankNameController: TextEditingController(text: value.name),
          );
          context.pop();
          //clearBankSearch();
        },
      ),
    );
  }

  Future<void> getBanksList() async {
    state = state.copyWith(fetchingBanks: true);
    final config = AppKeysStorage.getConfig();
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.loginAuthToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    try {
      final res = await RexApi.instance.bankList(header: header);
      state = state.copyWith(fetchingBanks: false, banksList: res);
    } catch (err, _) {
      debugPrintDev("error getting banks list $err");
    }
  }

  void _dispose() {
    state.bankNameController.dispose();
    state.accountNumberController.dispose();
    state.amountController.dispose();
    state.acctNameController.dispose();
    state.narrationController.dispose();
    state.searchController.dispose();
    state.bankSearchController.dispose();
    state.transferTabController?.dispose();
  }
}
