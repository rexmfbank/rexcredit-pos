// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/exceptions/rex_api_exception.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/notification/notification_model.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_card_purchase.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/pos_device/model/print_models/print_card_purchase.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/quick_purchase/model/baseapp_card_purchase_request.dart';
import 'package:rex_app/src/modules/quick_purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/quick_purchase/model/pos_card_purchase_state.dart';
import 'package:rex_app/src/modules/quick_purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/utils/app_keys.dart';
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
    debugPrintDev("INSIDE posCardPurchaseProvider BUILD");
    return PosCardPurchaseState(
      purchaseAmount: '',
      purchaseStatusCode: '',
      purchaseMessage: '',
      isLoading: false,
      isButtonEnabled: true,
      isTsqTransDataNull: false,
      isQuickPurchase: false,
      isPrintingDone: false,
      isTsqChecking: false,
      needsTsqCheck: false,
      hasReturn: false,
      batteryLevel: 0,
      rrnNumber: '',
      stanNumber: '',
      isFromNotif: false,
      posNotifAmount: '',
      posNotifTerminalSerialNo: '',
      posNotifRrn: '',
      posNotifStan: '',
      posNotifInvoiceId: '',
      posAcctNo: '',
      posSerialNo: '',
      posAuthToken: '',
      posTerminalId: '',
      posMerchantId: '',
      posMerchantName: '',
      posAppVersionLocal: '',
      rrnAmount: '',
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
      baseappCurrency: '',
      baseappMaskedPan: '',
      baseappMessage: '',
      baseappVersion: '',
      baseappCardExpiryDate: '',
      baseappCardHolderName: '',
      baseappAuthCode: '',
      baseappName: '',
      isInputEnabled: true,
    );
  }

  void initializeData() {
    final config = AppKeysStorage.getConfig();
    state = state.copyWith(
      posAcctNo: config.baasNuban,
      posSerialNo: config.serialNumber,
      posAuthToken: config.authToken,
      posTerminalId: config.baasTerminalId,
      posMerchantId: config.merchantId,
      posMerchantName: config.baasNubanName,
      posAppVersionLocal: config.appVersionLocal,
      baseappName: config.baseappName,
    );
  }

  void setPurchaseAmount(String value) {
    state = state.copyWith(purchaseAmount: value);
  }

  Future<void> doInputValidation({required bool quickPurchase}) async {
    final batteryLevel = await battery.batteryLevel;
    state = state.copyWith(
      isQuickPurchase: quickPurchase,
      isButtonEnabled: false,
      isInputEnabled: false,
      rrnAmount: state.purchaseAmount,
    );

    final amountString = state.purchaseAmount.trim();
    if (amountString.isEmpty || amountString.startsWith('0')) {
      _enableBtn('Input a valid amount');
      return;
    }

    final number = num.tryParse(amountString);
    if (number == null || number <= 0) {
      _enableBtn('Transaction amount must be greater than ₦0');
      return;
    }

    if (quickPurchase && state.posAuthToken.isEmpty) {
      _enableBtn('Identification failed. Download settings');
      return;
    }

    if (batteryLevel < 20) {
      _enableBtn('Device battery is low. Cannot Proceed');
      return;
    }

    if (state.posAcctNo.isEmpty && state.posSerialNo.isEmpty) {
      _enableBtn('Initializing, please try again in a moment');
      return;
    }
    state = state.copyWith(
      isLoading: true,
      isButtonEnabled: false,
      isInputEnabled: false,
    );
    doRrnRetrieval(quickPurchase: quickPurchase);
  }

  void _enableBtn(String message) {
    final context = rootNavKey.currentContext;
    if (context != null) {
      context.showSnack(message: message);
    }
    state = state.copyWith(isButtonEnabled: true, isInputEnabled: true);
  }

  Future<void> doRrnRetrieval({required bool quickPurchase}) async {
    final config = AppKeysStorage.getConfig();
    try {
      final request = RetrieveRrnRequest(
        amount: num.parse(state.purchaseAmount),
        terminalId: config.terminalId,
        transactionType: 'Card Purchase',
      );
      final header = HeaderWithAuthNoCrypt(
        appVersion: config.appVersionLocal,
        deviceID: config.serialNumber,
        authToken: config.authToken,
        geoLong: config.longitude,
        geoLat: config.latitude,
      );
      final res = await RexApi.instance.posRetrieveRRN(
        header: header,
        request: request,
      );
      state = state.copyWith(
        rrnNumber: res.data.rrn,
        stanNumber: res.data.stan,
        isLoading: false,
        isButtonEnabled: false,
      );
      doCardPurchase(quickPurchase: quickPurchase);
    } catch (e) {
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

  Future<void> doCardPurchase({required bool quickPurchase}) async {
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
    final baseAppName = AppKeysStorage.getConfig().baseappName;

    switch (baseAppName) {
      case Pkg.nexgo:
      case Pkg.nexgorex:
      case Pkg.telpo:
      case Pkg.topwise:
      case Pkg.topwise2:
        intentResult = await startIntentAndGetResult(
          packageName: Pkg.transaction,
          dataKey: "extraData",
          dataValue: '${intentRequest.toJson()}',
        );
        break;
      case Pkg.horizon:
        debugPrintDev('Cannot identify POS device');
        break;
      default:
        debugPrintDev('Cannot identify POS device');
        break;
    }
    //
    if (intentResult == null || intentResult.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isButtonEnabled: true,
        isInputEnabled: true,
      );
      return;
    }
    //
    final res = BaseAppTransResponse.fromJson(jsonDecode(intentResult));
    updateStateAfterBaseAppReturns(res);
    checkStatusCodeAndSubmitPurchase();
  }

  void updateStateAfterBaseAppReturns(BaseAppTransResponse response) {
    state = state.copyWith(
      purchaseAmount: '',
      purchaseStatusCode: response.statuscode,
      purchaseMessage: response.message,
      isButtonEnabled: true,
      isInputEnabled: true,
      hasReturn: true,
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
      baseappCurrency: response.currency,
      baseappMaskedPan: response.maskedPan,
      baseappMessage: response.message,
      baseappVersion: response.baseAppVersion,
      baseappCardExpiryDate: response.cardExpireDate,
      baseappCardHolderName: response.cardHolderName,
      baseappAuthCode: response.authcode,
    );
  }

  Future<void> doPrinting({required String copyType}) async {
    final config = AppKeysStorage.getConfig();
    //
    if (state.baseappAID.isEmpty) {
      debugPrintDev("Cannot print");
      return;
    }
    if (config.baseappName == Pkg.horizon) {
      debugPrintDev("Printing not available");
    } else {
      final filePath =
          Pkg.isTopwise(config.baseappName) ? topwiseFile : config.printImage;
      final data = jsonPrintCardPurchaseV2(
        print: PrintCardPurchase(
          filePath: filePath,
          copyType: copyType,
          appVersionText: "Version ${config.appVersionLocal}",
          merchantName: state.baseappMerchantName,
          merchantId: state.baseappMerchantId,
          terminalId: config.terminalId,
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

  Future<void> checkStatusCodeAndSubmitPurchase() async {
    final config = AppKeysStorage.getConfig();
    if (tsqCodeList.contains(state.purchaseStatusCode)) {
      state = state.copyWith(isLoading: true, isTsqChecking: true);
      try {
        final header = HeaderWithAuthNoCrypt(
          appVersion: config.appVersionLocal,
          deviceID: config.serialNumber,
          authToken: config.authToken,
          geoLong: config.longitude,
          geoLat: config.latitude,
        );
        final tsqResponse = await RexApi.instance.posTsqCheck(
          header: header,
          rrn: state.rrnNumber,
        );
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
        _playSuccessSound();
        submitPurchase();
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
        _playSuccessSound();
        submitPurchase();
      }
    } else {
      // here, status code is not in the list of codes that require TSQ check,
      // just submit the purchase
      state = state.copyWith(isTsqChecking: false);
      _playSuccessSound();
      submitPurchase();
    }
  }

  Future<void> submitPurchase() async {
    final config = AppKeysStorage.getConfig();
    state = state.copyWith(isLoading: true);
    //
    final quickPurchaseReq = PosQuickPurchaseRequest(
      amount: num.tryParse(state.baseappAmount) ?? 0.0,
      maskedPan: state.baseappPan,
      merchantName: state.posMerchantName,
      stan: state.baseappStan,
      statusCode: state.purchaseStatusCode,
      terminalId: state.posTerminalId,
      bankName: state.baseappBankName,
      transactionType: state.baseappTransType,
      rrn: state.baseappRRN,
      datetime: state.baseappDateTime,
      aid: state.baseappAID,
      transactionMessage: state.purchaseMessage,
      merchantCode: state.baseappMerchantId,
      merchantNuban: state.posAcctNo,
    );
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.authToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    debugPrintDev("QuickPurchase Request: ${quickPurchaseReq.toJson()} ");
    //
    bool success = false;
    int retryCount = 0;
    const maxRetries = 3;
    try {
      while (!success && retryCount < maxRetries) {
        try {
          await RexApi.instance.posQuickPurchase(
            header: header,
            request: quickPurchaseReq,
          );
          success = true;
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
      doPrinting(copyType: 'CUSTOMER COPY');
    }
  }

  Future<void> submitNfcPurchase({required String payLoad}) async {
    final config = AppKeysStorage.getConfig();
    state = state.copyWith(isLoading: true);
    final nfcRequest = PosNfcRequest(
      amount: num.parse(state.posNotifAmount),
      terminalId: state.posSerialNo,
      rrn: state.posNotifRrn,
      stan: state.posNotifStan,
      datetime: formatDateTimeSimple(DateTime.now()),
      cardPayload: payLoad,
      pin: '1234',
    );
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.authToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    debugPrintDev('submitNfcPurchase request: ${nfcRequest.toJson()}');
    //
    bool success = false;
    int retryCount = 0;
    const maxRetries = 3;
    //
    try {
      while (!success && retryCount < maxRetries) {
        try {
          await RexApi.instance.posNfcPurchase(
            header: header,
            request: nfcRequest,
          );
          success = true;
          debugPrintDev('submitNfcPurchase success');
        } catch (e) {
          retryCount++;
          if (retryCount >= maxRetries) {
            debugPrintDev('submitNfcPurchase failed, attempt $retryCount...');
            return;
          } else {
            await Future.delayed(const Duration(seconds: 1));
          }
        }
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void clearState() {
    state = state.copyWith(
      purchaseAmount: '',
      hasReturn: false,
      purchaseStatusCode: '',
      purchaseMessage: '',
      isLoading: false,
      isQuickPurchase: false,
      isButtonEnabled: true,
      isInputEnabled: true,
      isTsqTransDataNull: false,
      isTsqChecking: false,
      batteryLevel: 0,
      rrnAmount: '',
      rrnNumber: '',
      stanNumber: '',
      posAcctNo: '',
      posSerialNo: '',
      posAuthToken: '',
      posTerminalId: '',
      posMerchantId: '',
      posMerchantName: '',
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
      baseappCurrency: '',
      baseappMaskedPan: '',
      baseappMessage: '',
      baseappVersion: '',
      baseappCardExpiryDate: '',
      baseappCardHolderName: '',
      baseappAuthCode: '',
    );
  }
}
