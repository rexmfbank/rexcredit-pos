import 'dart:convert';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_method_channel.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_type.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_global_state.dart';
import 'package:rex_app/src/modules/shared/pos_device/printer_json.dart';
import 'package:rex_app/src/modules/shared/pos_device/printer_json2.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';

final posGlobalProvider =
    NotifierProvider<PosGlobalNotifier, PosGlobalState>(PosGlobalNotifier.new);

class PosGlobalNotifier extends Notifier<PosGlobalState> {
  @override
  PosGlobalState build() {
    return PosGlobalState();
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
        break;
      }
    }
  }

  Future<void> doKeyExchange() async {
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
        break;
      case PosPackage.horizon:
        Map<String, dynamic> purchase = {
          "transType": "KEY EXCHANGE",
          "amount": 0,
          "colour": "234567",
          "TID": "",
          "rrn": "",
          "stan": "",
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
      case PosPackage.topwise:
      case PosPackage.telpo:
        final data = getJsonForTestingPrinter(filePath);
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
      case PosPackage.topwise:
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
      case PosPackage.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosPackage.none:
        context.showToast(message: "Cannot identify device");
        break;
    }
  }
}
