// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/interceptors.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_test_printer.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_transaction_detail.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_transaction_detail2.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_transaction_detail3.dart';
import 'package:rex_app/src/modules/pos_device/model/key_exchange_result.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_global_state.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/pos_device/model/print_models/print_transaction_purchase.dart';
import 'package:rex_app/src/modules/pos_device/model/print_models/print_transaction_transfer.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_geolocation.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/utils/app_keys.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

final posGlobalProvider = NotifierProvider<PosGlobalNotifier, PosGlobalState>(
  PosGlobalNotifier.new,
);

class PosGlobalNotifier extends Notifier<PosGlobalState> with AppGeolocation {
  @override
  PosGlobalState build() {
    return PosGlobalState(hasBaseAppName: false, isLoading: false);
  }

  Future<void> checkBaseAppInstalled(BuildContext context) async {
    debugPrintDev("INSIDE CHECK-BASE-APP-INSTALLED FUNCTION");
    final config = AppKeysStorage.getConfig();
    final baseApplist = [
      Pkg.horizon,
      Pkg.nexgo,
      Pkg.nexgorex,
      Pkg.telpo,
      Pkg.topwise,
      Pkg.topwise2,
    ];
    for (final package in baseApplist) {
      final isInstalled = await AppCheck().isAppInstalled(package);
      if (isInstalled) {
        debugPrintDev("BASE-APP-INSTALLED: $package");
        //ref.read(baseAppNameProvider.notifier).state = package;
        final updateConfig = config.copyWith(baseappName: package);
        await AppKeysStorage.saveConfig(updateConfig);
        state = state.copyWith(hasBaseAppName: true);
        break;
      }
    }
    debugPrintDev(config.toString());
    doPosAuthentication(context: context);
  }

  Future<void> doPrintingTest(BuildContext context) async {
    // final filePath = ref.watch(printingImageProvider) ?? '';
    // final baseAppName = ref.watch(baseAppNameProvider);
    final config = AppKeysStorage.getConfig();
    final baseAppName = config.baseappName;
    switch (baseAppName) {
      case Pkg.nexgo:
      case Pkg.nexgorex:
      case Pkg.telpo:
        final data = getJsonForTestingPrinter(config.printImage);
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(data),
        );
        break;
      case Pkg.topwise:
      case Pkg.topwise2:
        final data = getJsonForTestingPrinter(topwiseFile);
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(data),
        );
        break;
      case Pkg.horizon:
        context.showSnack(message: 'Printing not available');
        break;
      case Pkg.none:
        context.showSnack(message: "Cannot identify device");
        break;
      default:
    }
  }

  void printQuickTransactionDetail({
    required PosTransactionsResponseData data,
    required BuildContext context,
  }) async {
    final config = AppKeysStorage.getConfig();
    final baseApp = config.baseappName;
    final printLogo = config.printImage;
    final merchantId = config.merchantId;
    final merchantName = config.baasNubanName;
    final terminalId = config.baasTerminalId;
    final appVersion = config.appVersionLocal;

    final filePath = Pkg.isTopwise(baseApp) ? topwiseFile : printLogo;
    final cardNarration =
        data.narration?.toLowerCase() == Strings.approvedLong
            ? Strings.approvedShort
            : data.narration ?? '';

    switch (baseApp) {
      case Pkg.nexgo:
      case Pkg.nexgorex:
      case Pkg.telpo:
      case Pkg.topwise:
      case Pkg.topwise2:
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
                    tranUniqRefNo: data.tranRefNo ?? '',
                    status: data.status ?? '',
                    beneficiaryName: '',
                    beneficiaryAccountNo: data.beneficiaryAccountNo ?? '',
                    beneficiaryBank: data.beneficiaryBank ?? '',
                    senderName: data.senderName ?? '',
                    senderAccountNumber: '',
                  ),
                );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case Pkg.horizon:
        context.showSnack(message: 'Printing not available');
        break;
      case Pkg.none:
        context.showSnack(message: "Cannot identify device");
        break;
    }
  }

  void printTransactionDetailInApp(
    BuildContext context,
    TransferData data,
  ) async {
    //final baseAppName = ref.watch(baseAppNameProvider);
    final config = AppKeysStorage.getConfig();
    final baseAppName = config.baseappName;
    switch (baseAppName) {
      case Pkg.nexgo:
      case Pkg.nexgorex:
      case Pkg.telpo:
        final dataJson = jsonPrintingTransactionDetailInApp(
          data,
          config.printImage,
        );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case Pkg.topwise:
      case Pkg.topwise2:
        final dataJson = jsonPrintingTransactionDetailInApp(data, topwiseFile);
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case Pkg.horizon:
        context.showSnack(message: 'Printing not available');
        break;
      case Pkg.none:
        context.showSnack(message: "Cannot identify device");
        break;
    }
  }

  Future<void> doKeyExchange({required BuildContext context}) async {
    final baseAppName = AppKeysStorage.getConfig().baseappName;
    switch (baseAppName) {
      case Pkg.nexgo:
      case Pkg.nexgorex:
      case Pkg.telpo:
      case Pkg.topwise:
      case Pkg.topwise2:
        final str = await startIntentAndGetResult(
          packageName: "com.globalaccelerex.keyexchange",
          dataKey: "extraData",
          dataValue: "",
        );
        debugPrintDev("Key Exchange Result: $str");
        getSerialNumberPOS(context: context);
        break;
      case Pkg.horizon:
      case Pkg.none:
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
      //
      final config = AppKeysStorage.getConfig();
      final updateConfig = config.copyWith(
        serialNumber: keyExchange.serialNumber,
        merchantId: keyExchange.merchantId,
        terminalId: keyExchange.terminalId,
        lastUpdatedAt: DateTime.now(),
      );
      await AppKeysStorage.saveConfig(updateConfig);
      doPosAuthentication(context: context);
    } else {
      state = state.copyWith(isLoading: false);
      context.showSnack(message: "Failed, cannot detect Base App");
    }
  }

  Future<void> doPosAuthentication({required BuildContext context}) async {
    if (!await ConnectionCheck.isConnected()) {
      context.showSnack(message: 'Internet connection lost!');
      return;
    }
    final config = AppKeysStorage.getConfig();
    //String location = '';
    ({String lat, String long}) location;
    debugPrintDev("INSIDE POS AUTH FUNCTION");
    debugPrintDev(AppKeysStorage.getConfig().toString());

    state = state.copyWith(isLoading: true);
    context.showSnack(message: 'Verifying location...');
    final locationCheck = await checkLocationIsEnabled();
    if (!locationCheck.success) {
      state = state.copyWith(isLoading: false);
      final message =
          locationCheck.reason == 'service'
              ? 'Please enable location service'
              : 'Please grant location permission';
      context.showSnack(message: message);
      return;
    } else {
      //location = await updateCurrentLocation();
      // if (location.isEmpty) {
      //   state = state.copyWith(isLoading: false);
      //   context.showSnack(message: Strings.downloadSetting3);
      //   return;
      // }
      location = await updateCurrentLocation2();
      if (location.lat.isEmpty || location.long.isEmpty) {
        state = state.copyWith(isLoading: false);
        context.showSnack(message: Strings.downloadSetting3);
        return;
      }
    }

    if (config.serialNumber.isNotEmpty) {
      context.showSnack(message: "Location verified. Identifying device");
      state = state.copyWith(isLoading: true);
      try {
        final header = HeaderNoAuthNoCrypt(
          appVersion: config.appVersionLocal,
          deviceID: config.serialNumber,
          geoLong: location.long,
          geoLat: location.lat,
        );
        final posAuth = await RexApi.instance.posAuthentication(header: header);
        final updateConfig = config.copyWith(
          baasNuban: posAuth.data.accountNo,
          baasNubanName: posAuth.data.accountName,
          baasTerminalId: posAuth.data.terminalId,
          authToken: posAuth.data.secret,
          isExchangeDone: 'done',
          isAuthFailed: 'false',
          latitude: location.lat,
          longitude: location.long,
          lastUpdatedAt: DateTime.now(),
        );
        await AppKeysStorage.saveConfig(updateConfig);

        state = state.copyWith(isLoading: false);
        context.showSnack(message: "Device Identification done");
        debugPrintDev("AFTER SUCCESSFUL IDENTIFICATION");
        debugPrintDev(AppKeysStorage.getConfig().toString());
      } catch (e) {
        state = state.copyWith(isLoading: false);
        await updateIsAuthFailed();
        context.showSnack(message: "Device Identification failed");
      }
    } else {
      state = state.copyWith(isLoading: false);
      await updateIsAuthFailed();
      context.showSnack(message: Strings.downloadSetting2);
    }
  }

  Future<void> updateIsAuthFailed() async {
    final config = AppKeysStorage.getConfig();
    final updateConfig = config.copyWith(
      isAuthFailed: 'true',
      lastUpdatedAt: DateTime.now(),
    );
    await AppKeysStorage.saveConfig(updateConfig);
  }
}
