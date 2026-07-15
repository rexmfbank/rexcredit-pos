// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/models/name_inquiry_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_int_state.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final transferIntProvider =
    AutoDisposeNotifierProvider<TransferIntNotifier, TransferIntState>(
      () => TransferIntNotifier(),
    );

class TransferIntNotifier extends AutoDisposeNotifier<TransferIntState> {
  @override
  TransferIntState build() {
    ref.onDispose(() => _dispose());
    return TransferIntState(
      amountController: TextEditingController(),
      accountNumberController: TextEditingController(),
      narrationController: TextEditingController(),
      isLoading: false,
      recipientCode: '',
      recipientAcctName: '',
      recipientAcctNo: '',
      recipientBankCode: '',
      recipientBankName: '',
    );
  }

  void validate(BuildContext context) {}

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
      bankCode: "090449",
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
      debugPrintDev("error on name inquiry:internal: $err");
    }
  }

  Future<void> internalTransfer(String pin, BuildContext context) async {
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
      context.go(Routes.dashboardHome);
    } catch (err, _) {
      state = state.copyWith(isLoading: false);
      debugPrintDev('error on send-money:internal: $err');
    }
  }

  void _dispose() {
    state.amountController.dispose();
    state.accountNumberController.dispose();
    state.narrationController.dispose();
  }
}
