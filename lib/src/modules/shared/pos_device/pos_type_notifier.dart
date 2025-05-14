import 'dart:convert';

import 'package:appcheck/appcheck.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_card_method_channel.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_type.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_type_state.dart';
import 'package:rex_app/src/modules/shared/pos_device/printer_json.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final posTypeProvider =
    NotifierProvider<PosTypeNotifier, PosTypeState>(PosTypeNotifier.new);

class PosTypeNotifier extends Notifier<PosTypeState> {
  @override
  PosTypeState build() {
    return PosTypeState();
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
        Map<String, dynamic> purchase = {
          "transType": "KEY EXCHANGE",
          "amount": 0,
          "colour": "234567",
          "TID": "",
          "rrn": "",
          "stan": "",
          "print": false
        };
        await startIntentAndGetResult(
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

  Future<void> doPrintingTest() async {
    final pos = getPosType();
    switch (pos) {
      case PosDevice.nexgo:
      case PosDevice.nexgorex:
      case PosDevice.telpo:
      case PosDevice.topwise:
        final data = getJsonForTestingPrinter();
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(data),
        );
        break;
      case PosDevice.horizon:
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
}
