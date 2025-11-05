// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_models/json_test_printer.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_models/json_transaction_detail.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_models/json_transaction_detail2.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/key_exchange_result.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_global_state.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/print_models/print_transaction_purchase.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/print_models/print_transaction_transfer.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_models/json_transaction_detail3.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/src/utils/interceptors.dart';
import 'package:rex_app/src/modules/revamp/utils/locator_mixin.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

final posGlobalProvider = NotifierProvider<PosGlobalNotifier, PosGlobalState>(
  PosGlobalNotifier.new,
);

class PosGlobalNotifier extends Notifier<PosGlobalState> with LocatorMix {
  @override
  PosGlobalState build() {
    return PosGlobalState(hasBaseAppName: false, isLoading: false);
  }

  Future<void> checkBaseAppInstalled(BuildContext context) async {
    final baseApplist = [
      PosPackage.horizon,
      PosPackage.nexgo,
      PosPackage.nexgorex,
      PosPackage.telpo,
      PosPackage.topwise,
    ];
    for (final package in baseApplist) {
      final isInstalled = await AppCheck().isAppInstalled(package);
      if (isInstalled) {
        ref.read(baseAppNameProvider.notifier).state = package;
        state = state.copyWith(hasBaseAppName: true);
        break;
      }
    }
    doPosAuthentication(context: context);
  }

  Future<void> doPrintingTest(BuildContext context) async {
    final filePath = ref.watch(printingImageProvider) ?? '';
    final baseAppName = ref.watch(baseAppNameProvider);
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
        final data = getJsonForTestingPrinter(filePath);
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(data),
        );
        break;
      case PosPackage.topwise:
        final data = getJsonForTestingPrinter(topwiseFile);
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(data),
        );
        break;
      case PosPackage.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosPackage.none:
        context.showToast(message: "Cannot identify device");
        break;
      default:
    }
  }

  void printQuickTransactionDetail({
    required PosTransactionsResponseData data,
    required BuildContext context,
  }) async {
    debugPrint("Print Quick Transaction Detail $data");
    final baseApp = ref.watch(baseAppNameProvider);
    final appVersion = ref.read(appVersionProvider);
    final printLogo = ref.watch(printingImageProvider) ?? '';
    final merchantId = await AppSecureStorage().getPosMerchantId() ?? '';
    final merchantName = await AppSecureStorage().getPosNubanName() ?? '';
    final terminalId = await AppSecureStorage().getBaasTerminalId() ?? '';
    final filePath = baseApp == PosPackage.topwise ? topwiseFile : printLogo;
    final cardNarration =
        data.narration?.toLowerCase() == Strings.approvedLong
            ? Strings.approvedShort
            : data.narration ?? '';
    //
    switch (baseApp) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
      case PosPackage.topwise:
        final dataJson =
            data.tranCode == 'CARD_PURCHASE'
                ? jsonPrintQuickTransDetailCARD(
                  print: PrintTransactionPurchase(
                    filePath: filePath,
                    appVersionText: "Version $appVersion",
                    merchantId: merchantId,
                    merchantName: merchantName,
                    terminalId: terminalId,
                    date: data.tranDate ?? '',
                    stan: data.stan ?? '',
                    rrn: data.rrn ?? '',
                    aid: data.aid ?? '',
                    amount: data.amount?.toCurrencyString() ?? '',
                    status: data.status ?? '',
                    narration: cardNarration,
                  ),
                )
                : jsonPrintQuickTransDetailNOCARD(
                  print: PrintTransactionTransfer(
                    filePath: filePath,
                    appVersionText: "Version $appVersion",
                    merchantId: merchantId,
                    merchantName: merchantName,
                    terminalId: terminalId,
                    tranDate: data.tranDate ?? '',
                    amount: data.amount?.toCurrencyString() ?? '',
                    tranUniqRefNo: data.tranUniqRefNo ?? '',
                    status: data.status ?? '',
                    beneficiaryName: data.beneficiaryName ?? '',
                    beneficiaryAccountNo: data.beneficiaryAccountNo ?? '',
                    beneficiaryBank: data.beneficiaryBank ?? '',
                    senderName: data.senderName ?? '',
                    senderAccountNumber: data.senderAccountNumber ?? '',
                  ),
                );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case PosPackage.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosPackage.none:
        context.showToast(message: "Cannot identify device");
        break;
    }
  }

  void printTransactionDetailInApp(
    BuildContext context,
    TransferData data,
  ) async {
    final baseAppName = ref.watch(baseAppNameProvider);
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
        final dataJson = jsonPrintingTransactionDetailInApp(
          data,
          ref.watch(printingImageProvider) ?? '',
        );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case PosPackage.topwise:
        final dataJson = jsonPrintingTransactionDetailInApp(data, topwiseFile);
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case PosPackage.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosPackage.none:
        context.showToast(message: "Cannot identify device");
        break;
    }
  }

  Future<void> doKeyExchange({required BuildContext context}) async {
    if (!await ConnectionCheck.isConnected()) {
      context.showToast(message: 'Internet connection lost!');
      return;
    }
    final baseAppName = ref.watch(baseAppNameProvider);
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
      case PosPackage.topwise:
        await startIntentAndGetResult(
          packageName: "com.globalaccelerex.keyexchange",
          dataKey: "extraData",
          dataValue: "",
        );
        getSerialNumberPOS(context: context);
        break;
      case PosPackage.horizon:
        Map<String, dynamic> purchase = {
          "transType": "KEY EXCHANGE",
          "amount": 10.0,
          "colour": "234567",
          "TID": "203537FV",
          "rrn": "134908756643",
          "stan": "345786",
          "print": true,
        };
        await startIntentK11AndGetResult(
          packageName: "com.globalaccelerex.horizonbaseapp",
          dataKey: "requestData",
          dataValue: jsonEncode(purchase),
        );
        break;
      case PosPackage.none:
        break;
    }
  }

  Future<void> getSerialNumberPOS({required BuildContext context}) async {
    if (state.hasBaseAppName) {
      state = state.copyWith(isLoading: true);
      final pData = jsonEncode({'action': 'PARAMETER', 'print': 'false'});
      final intentResult = await startIntentParameter(
        packageName: "com.globalaccelerex.utility",
        dataKey: "requestData",
        dataValue: pData,
      );
      final keyExchange = KeyExchangeResult.fromJson(
        jsonDecode(intentResult ?? ''),
      );
      AppSecureStorage().posSerialNoValue = keyExchange.serialNumber ?? '';
      AppSecureStorage().posMerchantIdValue = keyExchange.merchantId ?? '';
      AppSecureStorage().posTerminalIdValue = keyExchange.terminalId ?? '';
      state = state.copyWith(isLoading: false);
      doPosAuthentication(context: context);
    } else {
      state = state.copyWith(isLoading: false);
      context.showToastForNoBaseApp();
    }
  }

  Future<void> doPosAuthentication({required BuildContext context}) async {
    if (!await ConnectionCheck.isConnected()) {
      context.showToast(message: 'Internet connection lost!');
      return;
    }
    final serial = await AppSecureStorage().getPosSerialNo();
    final appVersion = ref.read(appVersionProvider);

    context.showToastUpdatingProcess("Verifying location");
    state = state.copyWith(isLoading: true);
    final position = await getCurrentPosition(context);
    context.showToastUpdatingProcess("Location verified");
    state = state.copyWith(isLoading: false);

    if (serial != null && serial.isNotEmpty) {
      context.showToastUpdatingProcess("Identifying device");
      state = state.copyWith(isLoading: true);
      try {
        final posAuth = await RexApi.instance.posAuthentication(
          serialNo: serial,
          appVersion: appVersion,
          geolocation: "${position?.latitude}, ${position?.longitude}",
        );
        AppSecureStorage().posNubanValue = posAuth.data.accountNo;
        AppSecureStorage().posNubanNameValue = posAuth.data.accountName;
        AppSecureStorage().baasTerminalIdValue = posAuth.data.terminalId;
        ref.read(posAuthTokenProvider.notifier).state = posAuth.data.secret;
        state = state.copyWith(isLoading: false);
        context.showToastForAuthDone();
      } catch (e) {
        state = state.copyWith(isLoading: false);
        context.showToastForAuthFailed();
      }
    } else {
      state = state.copyWith(isLoading: false);
      context.showToastForAuthFailedII();
    }
  }
}
