// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:appcheck/appcheck.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/interceptors.dart';
import 'package:rex_app/src/modules/api/models/extension_on_payload.dart';
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
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_config.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_geolocation.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';
import 'package:rex_app/src/modules/utils/widgets/extension_on_snackbar.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_number.dart';

final posGlobalProvider = NotifierProvider<PosGlobalNotifier, PosGlobalState>(
  PosGlobalNotifier.new,
);

const snackDuration = Duration(seconds: 2);

class PosGlobalNotifier extends Notifier<PosGlobalState> with AppGeolocation {
  @override
  PosGlobalState build() {
    return PosGlobalState(
      hasBaseAppName: false,
      isLoading: false,
      canPrint: true,
      message: '',
    );
  }

  void resetMessage() {
    state = state.copyWith(message: '');
  }

  Future<void> checkBaseAppInstalled(BuildContext context) async {
    debugPrintDev("INSIDE CHECK-BASE-APP-INSTALLED FUNCTION");
    final config = AppKeysStorage.getConfig();
    //
    bool encryptionOn = false;
    try {
      final res = await RexApi.instance.checkEncryption();
      encryptionOn = res.payloadEncryption ?? false;
      debugPrintDev("Encryption status: ${res.payloadEncryption}");
    } catch (err, _) {
      debugPrintDev("error on checking encryption: $err");
    }
    //
    final PackageInfo appVersion = await PackageInfo.fromPlatform();
    final version =
        AppConfig.shared.flavor == Flavor.dev
            ? appVersion.version.substring(0, 5)
            : appVersion.version;
    //
    for (final package in Pkg.baseApplist) {
      final isInstalled = await AppCheck().isAppInstalled(package);
      if (isInstalled) {
        debugPrintDev("BASE-APP-INSTALLED: $package");
        final updateConfig = config.copyWith(
          baseappName: package,
          appVersionLocal: version,
          onEncryption: encryptionOn,
        );
        await AppKeysStorage.saveConfig(updateConfig);
        state = state.copyWith(hasBaseAppName: true);
        break;
      }
    }
    debugPrintDev(config.toString());
    checkBeforeAuth();
  }

  Future<void> doPrintingTest(BuildContext context) async {
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

  void printTransDetail(PrintObjTransaction data) async {
    state = state.copyWith(canPrint: false);
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
            data.posType.isCardPurchaseNull
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
                    senderAccountNumber: data.senderAcctNo ?? '',
                  ),
                );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case Pkg.horizon:
      case Pkg.none:
        scaffoldMessengerKey.showSnack(message: 'Printing not available');
        break;
    }
    state = state.copyWith(canPrint: true);
  }

  void printTransactionDetailInApp(
    BuildContext context,
    TransferData data,
  ) async {
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
      checkBeforeAuth();
    } else {
      state = state.copyWith(isLoading: false);
      context.showSnack(message: "Failed, cannot detect Base App");
    }
  }

  void checkBeforeAuth() {
    final config = AppKeysStorage.getConfig();
    if (config.isFresh && config.isComplete) {
      state = state.copyWith(isLoading: false);
      debugPrintDev("Already authenticated");
      debugPrintDev(AppKeysStorage.getConfig().toString());
      return;
    } else {
      debugPrintDev("Unauthenticated, authenticating...");
      doPosAuthentication();
    }
  }

  Future<void> doPosAuthentication() async {
    if (!await ConnectionCheck.isConnected()) {
      state = state.copyWith(isLoading: false, message: Strings.pos5);
      return;
    }
    final config = AppKeysStorage.getConfig();
    debugPrintDev("INSIDE POS AUTH FUNCTION");
    debugPrintDev(AppKeysStorage.getConfig().toString());

    state = state.copyWith(isLoading: true, message: Strings.pos6);
    final location = await _getLocation();
    if (location.lat.isEmpty || location.long.isEmpty) {
      return;
    }

    // state = state.copyWith(isLoading: true, message: Strings.pos6);
    // final locationCheck = await checkLocationIsEnabled();
    // if (!locationCheck.success) {
    //   final message =
    //       locationCheck.reason == 'service'
    //           ? 'Please enable location service'
    //           : 'Please grant location permission';
    //   state = state.copyWith(isLoading: false, message: message);
    //   return;
    // } else {
    //   location = await updateCurrentLocation2();
    //   if (location.lat.isEmpty || location.long.isEmpty) {
    //     state = state.copyWith(isLoading: false, message: Strings.pos7);
    //     return;
    //   }
    // }

    if (config.serialNumber.isEmpty) {
      state = state.copyWith(isLoading: false, message: Strings.pos1);
      await updateIsAuthFailed();
    } else {
      debugPrintDev("ABOUT TO CALL DEVICE AUTHENTICATION");
      state = state.copyWith(isLoading: true, message: Strings.pos4);
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
          tippingEnabled: posAuth.data.tippingEnabled,
        );
        await AppKeysStorage.saveConfig(updateConfig);
        state = state.copyWith(isLoading: false, message: Strings.pos3);
        _playSuccessSound();
        debugPrintDev("AFTER SUCCESSFUL IDENTIFICATION");
        debugPrintDev(AppKeysStorage.getConfig().toString());
      } catch (e) {
        state = state.copyWith(isLoading: false, message: Strings.pos2);
        await updateIsAuthFailed();
      }
    }
  }

  Future<({String lat, String long})> _getLocation() async {
    final config = AppKeysStorage.getConfig();
    ({String lat, String long}) loc;
    //
    if (config.hasLocation) {
      debugPrintDev("USING EXISTING FRESH LOCATION DATA");
      loc = (lat: config.latitude, long: config.longitude);
    } else {
      debugPrintDev('GETTING FRESH LOCATION DATA');
      final checkLoc = await checkLocationIsEnabled();
      if (!checkLoc.success) {
        final msg = checkLoc.reason == 'service' ? Strings.geo1 : Strings.geo2;
        state = state.copyWith(isLoading: false, message: msg);
        loc = (lat: '', long: '');
      } else {
        final updateLoc = await updateCurrentLocation();
        if (updateLoc.lat.isEmpty || updateLoc.long.isEmpty) {
          state = state.copyWith(isLoading: false, message: Strings.pos7);
          loc = (lat: '', long: '');
        } else {
          debugPrintDev('NEW LOCATION DATA GOTTEN');
          loc = (lat: updateLoc.lat, long: updateLoc.long);
          final updateConfig = config.copyWith(
            latitude: updateLoc.lat,
            longitude: updateLoc.long,
            lastUpdatedAt: DateTime.now(),
          );
          await AppKeysStorage.saveConfig(updateConfig);
        }
      }
    }
    return loc;
  }

  Future<void> updateIsAuthFailed() async {
    final config = AppKeysStorage.getConfig();
    final updateConfig = config.copyWith(
      isAuthFailed: 'true',
      lastUpdatedAt: DateTime.now(),
    );
    await AppKeysStorage.saveConfig(updateConfig);
  }

  void _playSuccessSound() {
    AudioPlayer().play(AssetSource('audio/beeptwo.wav'));
  }
}
