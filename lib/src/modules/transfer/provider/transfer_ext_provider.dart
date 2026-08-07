// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/models/name_inquiry_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_state.dart';
import 'package:rex_app/src/modules/transfer/widgets/bank_list.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
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
      allBanks: [],
      tabIndex: 0,
      msgError: '',
      msgSuccess: '',
    );
  }

  void notifyFormChanged() {
    state = state.copyWith();
  }

  void resetMessage() {
    state = state.copyWith(msgError: '', msgSuccess: '');
  }

  void clearRecipientName() {
    state = state.copyWith(recipientAcctName: '');
  }

  Future<void> validateAcct(String value) async {
    if (value.length < 10 && state.isLoading) {
      return;
    }
    state = state.copyWith(isLoading: true, recipientAcctName: '');
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
      state = state.copyWith(isLoading: false, msgError: err.toString());
      debugPrintDev("error on name inquiry:interbank: $err");
    }
  }

  Future<void> interbankTransfer(String pin) async {
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
      senderAcctNo: config.loginNuban,
      borrowerId: int.parse(config.borrowerID),
      amount: state.amountController.text.replaceAll(',', ''),
      narration: state.narrationController.text,
      recipientCode: state.recipientCode,
      pin: pin,
    );
    try {
      await RexApi.instance.sendMoney(header: header, request: request);
      state = state.copyWith(
        isLoading: false,
        msgSuccess: 'Transfer successful',
        msgError: '',
      );
    } catch (err, _) {
      state = state.copyWith(
        isLoading: false,
        msgError: err.toString(),
        msgSuccess: '',
      );
      debugPrintDev('error on send-money:interbank: $err');
    }
  }

  void showBankList(BuildContext context) {
    state = state.copyWith(
      bankNameController: TextEditingController(text: ''),
      accountNumberController: TextEditingController(text: ''),
      recipientAcctName: '',
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
          clearBankSearch();
        },
      ),
    );
  }

  void clearBankSearch() {
    state = state.copyWith(
      bankSearchController: TextEditingController(),
      banksList: state.allBanks,
    );
  }

  void filterBanks(String query) {
    if (query.isEmpty) {
      state = state.copyWith(banksList: state.allBanks);
      return;
    }

    final input = query.toLowerCase();
    final filtered =
        state.allBanks.where((bank) {
          final bankName = (bank.name ?? '').toLowerCase();
          return bankName.contains(input);
        }).toList();

    state = state.copyWith(banksList: filtered);
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
      res.sort(
        (a, b) => (a.name ?? '').toLowerCase().compareTo(
          (b.name ?? '').toLowerCase(),
        ),
      );
      state = state.copyWith(
        fetchingBanks: false,
        banksList: res,
        allBanks: res,
      );
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

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
