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

  PosDevice getPosType() {
    final baseAppName = ref.watch(baseAppNameProvider);
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
        return PosDevice.nexgo;
      case PosPackage.telpo:
        return PosDevice.telpo;
      case PosPackage.horizon:
        return PosDevice.horizon;
      case PosPackage.topwise:
        return PosDevice.topwise;
      default:
        return PosDevice.none;
    }
  }

  Future<void> doKeyExchange() async {
    final pos = getPosType();
    switch (pos) {
      case PosDevice.nexgo:
      case PosDevice.nexgorex:
      case PosDevice.telpo:
      case PosDevice.topwise:
        await startIntentAndGetResult(
          packageName: "com.globalaccelerex.keyexchange",
          dataKey: "extraData",
          dataValue: "",
        );
        break;
      //
      case PosDevice.horizon:
        // rrn 12 digits
        // stan 6 digits
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
      //
      case PosDevice.none:
        break;
    }
  }

  Future<void> doPrintingTest(BuildContext context) async {
    final filePath = ref.watch(printingImageProvider) ?? '';
    final pos = getPosType();
    switch (pos) {
      case PosDevice.nexgo:
      case PosDevice.nexgorex:
      case PosDevice.telpo:
      case PosDevice.topwise:
        final data = getJsonForTestingPrinter(filePath);
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(data),
        );
        break;
      case PosDevice.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosDevice.none:
        break;
      default:
    }
  }

  Future<void> doCardPurchase() async {
    final pos = getPosType();
    switch (pos) {
      case PosDevice.nexgo:
      case PosDevice.nexgorex:
      case PosDevice.telpo:
      case PosDevice.topwise:
      default:
    }
  }

  void printTransferDetail(BuildContext context, TransferData data) async {
    final pos = getPosType();
    switch (pos) {
      case PosDevice.nexgo:
      case PosDevice.nexgorex:
      case PosDevice.telpo:
      case PosDevice.topwise:
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
      case PosDevice.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosDevice.none:
        break;
    }
  }
}
