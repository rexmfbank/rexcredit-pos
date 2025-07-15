// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/key_exchange_result.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_global_state.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/printer_json.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/printer_json2.dart';

import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/revamp/utils/secure_storage.dart';

final posGlobalProvider =
    NotifierProvider<PosGlobalNotifier, PosGlobalState>(PosGlobalNotifier.new);

class PosGlobalNotifier extends Notifier<PosGlobalState> {
  @override
  PosGlobalState build() {
    return PosGlobalState(hasBaseAppName: false, isLoading: false);
  }

  Future<void> checkBaseAppInstalled() async {
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
  }

  Future<void> doKeyExchange({
    required BuildContext context,
  }) async {
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
        doPosAuthentication(context: context);
        break;
      case PosPackage.horizon:
        Map<String, dynamic> purchase = {
          "transType": "KEY EXCHANGE",
          "amount": 10.0,
          "colour": "234567",
          "TID": "203537FV",
          "rrn": "134908756643",
          "stan": "345786",
          "print": true
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
        final data = getJsonForTestingPrinter(topwiseFilePath);
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

  void printTransferDetail(BuildContext context, TransferData data) async {
    final baseAppName = ref.watch(baseAppNameProvider);
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
        final dataJson = getJsonForPrintingTransactionDetail(
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
        final dataJson = getJsonForPrintingTransactionDetail(
          data,
          topwiseFilePath,
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

  Future<void> doPosAuthentication({
    required BuildContext context,
  }) async {
    if (state.hasBaseAppName) {
      state = state.copyWith(isLoading: true);
      final pData = jsonEncode({
        'action': 'PARAMETER',
        'print': 'false',
      });
      final intentResult = await startIntentParameter(
        packageName: "com.globalaccelerex.utility",
        dataKey: "requestData",
        dataValue: pData,
      );
      final keyExchange =
          KeyExchangeResult.fromJson(jsonDecode(intentResult ?? ''));
      ref.read(serialNumberProvider.notifier).state =
          keyExchange.serialNumber ?? '';
      ref.read(terminalIdProvider.notifier).state =
          keyExchange.terminalId ?? '';
      ref.read(merchantNameProvider.notifier).state =
          keyExchange.merchantName ?? '';
      //
      try {
        final posAuth = await RexApi.instance.posAuthentication(
          serialNo: ref.read(serialNumberProvider),
        );
        SecureStorage().posNubanValue = posAuth.data.accountNo;
        ref.read(posAuthTokenProvider.notifier).state = posAuth.data.secret;
        ref.read(merchantNubanProvider.notifier).state = posAuth.data.accountNo;
        ref.read(settingsDoneProvider.notifier).state = true;
        state = state.copyWith(isLoading: false);
        context.showToastForDoneSettings();
      } catch (e) {
        state = state.copyWith(isLoading: false);
        showModalActionError(
          context: context,
          title: "Download Settings failed",
          errorText: "Please try again",
        );
      }
    } else {
      context.showToast(message: "Download Settings failed. Try again");
    }
  }
}

const topwiseFilePath =
    'https://res.cloudinary.com/dpepsmzmw/image/upload/v1749626258/rex_logo_2_pz5iju.png';
