// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/exceptions/rex_api_exception.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/notification/notification_model.dart';
import 'package:rex_app/src/modules/utils/app_functions.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_card_purchase.dart';
import 'package:rex_app/src/modules/pos_device/model/print_models/print_card_purchase.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/api/dio/interceptors.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/purchase/model/baseapp_card_purchase_request.dart';
import 'package:rex_app/src/modules/purchase/model/horizon_data.dart';
import 'package:rex_app/src/modules/purchase/model/pos_card_purchase_state.dart';
import 'package:rex_app/src/modules/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/utils/app_preference_provider.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';
import 'package:rex_app/src/modules/utils/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

final posCardPurchaseProvider =
    NotifierProvider<PosCardPurchaseNotifier, PosCardPurchaseState>(
      PosCardPurchaseNotifier.new,
    );

class PosCardPurchaseNotifier extends Notifier<PosCardPurchaseState> {
  final battery = Battery();
  final tsqCodeList = {'91', '96'};

  @override
  PosCardPurchaseState build() {
    return PosCardPurchaseState(
      purchaseAmount: '',
      purchaseStatusCode: '',
      purchaseMessage: '',
      isLoading: false,
      isButtonEnabled: true,
      isTsqTransDataNull: false,
      isPrintingDone: false,
      isTsqChecking: false,
      needsTsqCheck: false,
      rrnNumber: '',
      stanNumber: '',
      isFromNotif: false,
      posNotifAmount: '',
      posNotifTerminalSerialNo: '',
      posNotifRrn: '',
      posNotifStan: '',
      posNotifInvoiceId: '',
      rrnAmount: '',
      acctNo: '',
      serialNo: '',
      tsqCheckCode: '',
      tsqCheckMessage: '',
      baseappAmount: '',
      baseappPan: '',
      baseappRRN: '',
      baseappStan: '',
      baseappBankName: '',
      baseappTransType: '',
      baseappDateTime: '',
      baseappAID: '',
      baseappMerchantId: '',
      baseappMerchantName: '',
      baseappLabel: '',
      baseappStatusCode: '',
      isInputEnabled: true,
    );
  }

  void setPurchaseAmount(String value) {
    state = state.copyWith(purchaseAmount: value);
  }

  Future<void> doInputValidation({required BuildContext context}) async {
    state = state.copyWith(
      isButtonEnabled: false,
      isInputEnabled: false,
      rrnAmount: state.purchaseAmount,
    );
    try {
      final posAuthToken = ref.read(posAuthTokenProvider) ?? '';

      final amountString = state.purchaseAmount.trim();
      if (amountString.isEmpty || amountString.startsWith('0')) {
        _enableBtn(context, 'Input a valid amount');
        return;
      }

      final number = num.tryParse(amountString);
      if (number == null || number <= 0) {
        _enableBtn(context, 'Transaction amount must be greater than ₦0');
        return;
      }

      if (posAuthToken.isEmpty) {
        _enableBtn(context, 'Identification failed. Download settings');
        return;
      }

      final bool isConnected;
      try {
        isConnected = await ConnectionCheck.isConnected();
      } catch (e) {
        _enableBtn(context, 'Unable to check connection. Please try again.');
        return;
      }
      if (!isConnected) {
        _enableBtn(context, 'Internet connection lost!');
        return;
      }

      final int batteryLevel;
      try {
        batteryLevel = await battery.batteryLevel;
        if (batteryLevel < 20) {
          _enableBtn(context, 'Device battery is low. Cannot Proceed');
          return;
        }
      } catch (e) {
        _enableBtn(context, "Unable to check battery level. Try again");
        return;
      }
      //
      final acctNo = await AppSecureStorage().getBaasNuban() ?? '';
      final serialNo = await AppSecureStorage().getPosSerialNo() ?? '';
      state = state.copyWith(
        isLoading: true,
        isButtonEnabled: false,
        acctNo: acctNo,
        serialNo: serialNo,
        isInputEnabled: false,
      );
      doRrnRetrieval(context: context);
    } catch (e) {
      _enableBtn(context, 'An unexpected error occurred. Please try again.');
    }
  }

  void _enableBtn(BuildContext context, String message) {
    context.showSnack(message: message);
    state = state.copyWith(isButtonEnabled: true, isInputEnabled: true);
  }

  Future<void> doRrnRetrieval({required BuildContext context}) async {
    final terminalId = await AppSecureStorage().getBaasTerminalId() ?? '';
    final authToken = ref.read(posAuthTokenProvider) ?? '';
    final appVersion = ref.read(appVersionProvider);
    context.showSnack(message: "Getting payment authorisation");
    try {
      final request = RetrieveRrnRequest(
        amount: num.parse(state.purchaseAmount),
        terminalId: terminalId,
        transactionType: 'Card Purchase',
      );
      final res = await RexApi.instance.posRetrieveRRN(
        authToken: authToken,
        appVersion: appVersion,
        request: request,
      );
      state = state.copyWith(
        rrnNumber: res.data.rrn,
        stanNumber: res.data.stan,
        isLoading: false,
        isButtonEnabled: false,
      );
      doCardPurchase(context: context);
    } catch (e) {
      context.showSnack(message: "Please try again");
      state = state.copyWith(
        isLoading: false,
        isButtonEnabled: true,
        isInputEnabled: true,
      );
    }
  }

  void setNotificationData({required PosNotification data}) {
    debugPrintDev('INSIDE SET DATA FOR NOTIF PURCHASE');
    state = state.copyWith(
      posNotifAmount: data.amount,
      posNotifTerminalSerialNo: data.terminalSerialNo,
      posNotifRrn: data.rrn,
      posNotifStan: data.stan,
      posNotifInvoiceId: data.invoiceId,
      isFromNotif: true,
    );
  }

  /// Resets notification-related state to prevent stale data from being used
  /// if user navigates away without completing a notification-initiated purchase.
  void resetNotificationState() {
    debugPrintDev('RESETTING NOTIFICATION STATE');
    state = state.copyWith(
      isFromNotif: false,
      posNotifAmount: '',
      posNotifTerminalSerialNo: '',
      posNotifRrn: '',
      posNotifStan: '',
      posNotifInvoiceId: '',
    );
  }

  Future<void> doCardPurchase({required BuildContext context}) async {
    final intentRequest =
        state.isFromNotif
            ? BaseAppCardPurchaseRequest(
              transactionType: PosCardTransactionType.purchase.key,
              amount: state.posNotifAmount,
              print: "false",
              rrn: state.posNotifRrn,
              stan: state.posNotifStan,
            )
            : BaseAppCardPurchaseRequest(
              transactionType: PosCardTransactionType.purchase.key,
              amount: state.rrnAmount,
              print: "false",
              rrn: state.rrnNumber,
              stan: state.stanNumber,
            );

    debugPrintDev('INTENT REQUEST: doCardPurchase: ${intentRequest.toJson()}');
    String? intentResult;
    final baseAppName = ref.watch(baseAppNameProvider);

    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
      case PosPackage.topwise:
        intentResult = await startIntentAndGetResult(
          packageName: PosPackage.transaction,
          dataKey: "extraData",
          dataValue: '${intentRequest.toJson()}',
        );
        break;
      case PosPackage.horizon:
        HorizonData horizonData = HorizonData(
          transType: "PURCHASE",
          amount: "10.0",
          colour: "234567",
          tid: "203537FV",
          print: true,
        );
        intentResult = await startIntentK11AndGetResult(
          packageName: PosPackage.horizon,
          dataKey: "requestData",
          dataValue: jsonEncode(horizonData.toJson()),
        );
        break;
      default:
        context.showSnack(message: 'Cannot identify POS device');
        break;
    }
    //
    if (intentResult == null || intentResult.isEmpty) {
      // cancel the purchase
      return;
    }
    //
    final res = BaseAppTransResponse.fromJson(jsonDecode(intentResult));
    updateStateAfterBaseAppReturns(res);
    //
    if (context.mounted) {
      context.push(Routes.quickPurchaseStatus);
      checkStatusCodeAndSubmitPurchase(context);
    } else {
      final navContext = rootNavKey.currentContext;
      if (navContext != null) {
        navContext.push(Routes.quickPurchaseStatus);
        checkStatusCodeAndSubmitPurchase(navContext);
      }
    }
    //
    /*if (tsqCheckCodes.contains(state.purchaseStatusCode)) {
      state = state.copyWith(needsTsqCheck: true);
      doTsqCheck(context, 'CUSTOMER COPY');
    } else {
      state = state.copyWith(needsTsqCheck: false);
      _playSuccessSound();
      submitPurchase(context);
    }*/
  }

  void updateStateAfterBaseAppReturns(BaseAppTransResponse response) {
    state = state.copyWith(
      purchaseAmount: '',
      purchaseStatusCode: response.statuscode,
      purchaseMessage: response.message,
      isButtonEnabled: true,
      isInputEnabled: true,
      baseappAmount: response.amount,
      baseappPan: response.maskedPan,
      baseappRRN: response.rrn,
      baseappStan: response.stan,
      baseappBankName: response.bankName,
      baseappTransType: response.transactionType,
      baseappDateTime: response.datetime,
      baseappAID: response.aid,
      baseappMerchantId: response.merchantId,
      baseappMerchantName: response.merchantName,
      baseappLabel: response.appLabel,
      baseappStatusCode: response.statuscode,
    );
  }

  Future<void> doPrinting({
    required BuildContext context,
    required String copyType,
  }) async {
    final baseApp = ref.watch(baseAppNameProvider);
    final appVersion = ref.read(appVersionProvider);
    final printLogo = ref.watch(printingImageProvider) ?? '';
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    //
    if (state.baseappAID.isEmpty) {
      context.showSnack(message: "Cannot print");
      return;
    }
    if (baseApp == PosPackage.horizon) {
      context.showSnack(message: "Printing not available");
    } else {
      final filePath = baseApp == PosPackage.topwise ? topwiseFile : printLogo;
      final data = jsonPrintCardPurchaseV2(
        print: PrintCardPurchase(
          filePath: filePath,
          copyType: copyType,
          appVersionText: "Version $appVersion",
          merchantName: state.baseappMerchantName,
          merchantId: state.baseappMerchantId,
          terminalId: terminalId ?? '',
          datetime: state.baseappDateTime,
          aid: state.baseappAID,
          maskedPan: state.baseappPan,
          stan: state.baseappStan,
          rrn: state.baseappRRN,
          amount: state.baseappAmount,
          appLabel: state.baseappLabel,
          message:
              state.purchaseStatusCode == '00'
                  ? 'Approved'
                  : state.purchaseMessage,
        ),
      );
      await startIntentPrinterAndGetResult(
        packageName: "com.globalaccelerex.printer",
        dataKey: "extraData",
        dataValue: jsonEncode(data),
      );
    }
  }

  void _playSuccessSound() {
    AudioPlayer().play(AssetSource('audio/beeptwo.wav'));
  }

  Future<void> checkStatusCodeAndSubmitPurchase(BuildContext context) async {
    if (tsqCodeList.contains(state.purchaseStatusCode)) {
      state = state.copyWith(isLoading: true, isTsqChecking: true);
      context.showSnack(message: Strings.confirmTsqStatus);
      try {
        final tsqResponse = await RexApi.instance.posTsqCheck(
          appVersion: ref.read(appVersionProvider),
          authToken: ref.read(posAuthTokenProvider) ?? '',
          rrn: state.rrnNumber,
        );
        context.showSnack(message: Strings.confirmTsqStatus2);
        //
        if (tsqResponse.tsqTransData == null) {
          state = state.copyWith(isTsqTransDataNull: true);
        } else {
          final code =
              tsqResponse.tsqTransData?.responseCode ??
              state.purchaseStatusCode;
          final message =
              tsqResponse.tsqTransData?.status ?? state.purchaseMessage;
          state = state.copyWith(
            purchaseStatusCode: code,
            purchaseMessage: message,
          );
        }
        //
        state = state.copyWith(isTsqChecking: false);
        context.showSnack(message: Strings.confirmTsqStatus);
        _playSuccessSound();
        submitPurchase(context);
      } catch (err) {
        String resCode = 'UNKNOWN';
        String resMessage = err.toString();
        if (err is RexApiException) {
          resCode = err.responseCode ?? 'UNKNOWN';
          resMessage = err.responseMessage ?? err.message ?? err.toString();
        }
        debugPrintDev("doTsqCheck failed");
        debugPrintDev("Error code: $resCode");
        debugPrintDev("Error message: $resMessage");
        state = state.copyWith(isTsqChecking: false);
        context.showSnack(message: Strings.confirmTsqStatus);
        _playSuccessSound();
        submitPurchase(context);
      }
    } else {
      // here, status code is not in the list of codes that require TSQ check,
      // just submit the purchase
      state = state.copyWith(isTsqChecking: false);
      _playSuccessSound();
      submitPurchase(context);
    }
  }

  Future<void> submitPurchase(BuildContext context) async {
    String popup = '';
    state = state.copyWith(isLoading: true);
    context.showSnack(message: Strings.submitPurchase6);
    final acctName = await AppSecureStorage().getBaasNubanName();
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    //
    final quickPurchaseRequest = PosQuickPurchaseRequest(
      amount: num.tryParse(state.baseappAmount) ?? 0.0,
      maskedPan: state.baseappPan,
      merchantName: acctName ?? "",
      stan: state.baseappStan,
      statusCode: state.purchaseStatusCode,
      terminalId: terminalId ?? "",
      bankName: state.baseappBankName,
      transactionType: state.baseappTransType,
      rrn: state.baseappRRN,
      datetime: state.baseappDateTime,
      aid: state.baseappAID,
      transactionMessage: state.purchaseMessage,
      merchantCode: state.baseappMerchantId,
      merchantNuban: state.acctNo,
    );
    //
    bool success = false;
    int retryCount = 0;
    const maxRetries = 3;

    try {
      while (!success && retryCount < maxRetries) {
        try {
          await RexApi.instance.posQuickPurchase(
            appVersion: ref.read(appVersionProvider),
            authToken: ref.read(posAuthTokenProvider) ?? '',
            request: quickPurchaseRequest,
          );
          success = true;
          popup = 'complete';
        } catch (err, _) {
          retryCount++;
          if (retryCount >= maxRetries) {
            String resCode = 'UNKNOWN';
            String resMessage = err.toString();
            if (err is RexApiException) {
              resCode = err.responseCode ?? 'UNKNOWN';
              resMessage = err.responseMessage ?? err.message ?? err.toString();
            }
            debugPrintDev('submitPurchase failed, attempt $retryCount...');
            debugPrintDev("Error code: $resCode");
            debugPrintDev("Error message: $resMessage");
          } else {
            await Future.delayed(const Duration(seconds: 1));
          }
        }
      }
    } finally {
      state = state.copyWith(isLoading: false, isFromNotif: false);
      context.showSnack(message: "Process $popup. Printing...");
      doPrinting(context: context, copyType: 'CUSTOMER COPY');
    }
  }

  Future<void> submitNfcPurchase({
    required BuildContext context,
    required String payLoad,
  }) async {
    state = state.copyWith(isLoading: true);
    final serialNo = await AppSecureStorage().getPosSerialNo() ?? '';
    //
    final nfcRequest = PosNfcRequest(
      amount: num.parse(state.posNotifAmount),
      terminalId: serialNo,
      rrn: state.posNotifRrn,
      stan: state.posNotifStan,
      datetime: formatDateTimeSimple(DateTime.now()),
      cardPayload: payLoad,
      pin: '1234',
    );
    debugPrintDev('submitNfcPurchase request: ${nfcRequest.toJson()}');
    //
    bool success = false;
    int retryCount = 0;
    const maxRetries = 3;
    //
    while (!success && retryCount < maxRetries) {
      try {
        await RexApi.instance.posNfcPurchase(
          request: nfcRequest,
          appVersion: ref.read(appVersionProvider),
          authToken: ref.read(posAuthTokenProvider) ?? '',
        );
        success = true;
        context.showSnack(message: "Transaction successful");
        debugPrintDev('submitNfcPurchase success');
      } catch (e) {
        retryCount++;
        debugPrintDev('submitNfcPurchase failed, attempt $retryCount...');
        if (retryCount >= maxRetries) {
          state = state.copyWith(isLoading: false);
          context.showSnack(
            message: "Transaction submission failed. Please try again.",
          );
          return;
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    //
    state = state.copyWith(isLoading: false);
  }
}
