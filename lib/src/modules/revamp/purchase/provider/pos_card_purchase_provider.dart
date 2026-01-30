// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_models/json_card_purchase.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/print_models/print_card_purchase.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/src/utils/interceptors.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_card_purchase_request.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/horizon_data.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/pos_card_purchase_state.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final posCardPurchaseProvider =
    NotifierProvider<PosCardPurchaseNotifier, PosCardPurchaseState>(
      PosCardPurchaseNotifier.new,
    );

class PosCardPurchaseNotifier extends Notifier<PosCardPurchaseState> {
  final battery = Battery();

  final tsqCheckCodes = {'91', '96'};

  @override
  PosCardPurchaseState build() {
    return PosCardPurchaseState(
      baseAppResponse: BaseAppTransResponse.empty(),
      tsqTransData: TsqTransactionData.empty(),
      purchaseAmount: '',
      purchaseStatusCode: '',
      purchaseMessage: '',
      isLoading: false,
      isQuickPurchase: false,
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
    );
  }

  void setPurchaseAmount(String value) {
    state = state.copyWith(purchaseAmount: value);
  }

  Future<void> doInputValidation({
    required BuildContext context,
    required bool quickPurchase,
  }) async {
    state = state.copyWith(
      isQuickPurchase: quickPurchase,
      isButtonEnabled: false,
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

      if (quickPurchase && posAuthToken.isEmpty) {
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

      state = state.copyWith(isLoading: true, isButtonEnabled: false);
      doRrnRetrieval(context: context, quickPurchase: quickPurchase);
    } catch (e) {
      _enableBtn(context, 'An unexpected error occurred. Please try again.');
    }
  }

  void _enableBtn(BuildContext context, String message) {
    context.showToast(message: message);
    state = state.copyWith(isButtonEnabled: true);
  }

  Future<void> doRrnRetrieval({
    required BuildContext context,
    required bool quickPurchase,
  }) async {
    //state = state.copyWith(isLoading: true, isButtonEnabled: false);
    final terminalId = await AppSecureStorage().getBaasTerminalId() ?? '';
    final authToken = ref.read(posAuthTokenProvider) ?? '';
    final appVersion = ref.read(appVersionProvider);
    context.showToast(message: "Getting payment authorisation");
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
      doCardPurchase(context: context, quickPurchase: quickPurchase);
    } catch (e) {
      context.showToast(message: "Please try again");
      state = state.copyWith(isLoading: false, isButtonEnabled: true);
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
      isQuickPurchase: true,
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
        context.showToast(message: "Transaction successful");
        debugPrintDev('submitNfcPurchase success');
      } catch (e) {
        retryCount++;
        debugPrintDev('submitNfcPurchase failed, attempt $retryCount...');
        if (retryCount >= maxRetries) {
          state = state.copyWith(isLoading: false);
          context.showToast(
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

  Future<void> doCardPurchase({
    required BuildContext context,
    required bool quickPurchase,
  }) async {
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
              amount: state.purchaseAmount,
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
        context.showToast(message: 'Cannot identify POS device');
        break;
    }
    state = state.copyWith(purchaseAmount: '', isButtonEnabled: true);
    final res = BaseAppTransResponse.fromJson(jsonDecode(intentResult ?? ""));
    state = state.copyWith(
      baseAppResponse: res,
      purchaseStatusCode: res.statuscode,
      isButtonEnabled: true,
    );
    debugPrintDev('BASE APP RESPONSE: ${res.toJson()}');
    //
    if (quickPurchase) {
      context.push(Routes.quickPurchaseStatus);
    } else {
      context.push("${Routes.dashboardIndividual}/${Routes.purchaseStatus}");
    }
    //
    if (tsqCheckCodes.contains(state.purchaseStatusCode)) {
      state = state.copyWith(needsTsqCheck: true);
      doTsqCheck(context, 'CUSTOMER COPY');
    } else {
      state = state.copyWith(needsTsqCheck: false);
      _playSuccessSound();
      submitPurchase(context);
    }
  }

  void _playSuccessSound() {
    AudioPlayer().play(AssetSource('audio/beeptwo.wav'));
  }

  Future<void> doTsqCheck(BuildContext context, String copyType) async {
    state = state.copyWith(isLoading: true, isTsqChecking: true);
    try {
      final tsqResponse = await RexApi.instance.posTsqCheck(
        appVersion: ref.read(appVersionProvider),
        authToken: ref.read(posAuthTokenProvider) ?? '',
        rrn: state.isFromNotif ? state.posNotifRrn : state.rrnNumber,
      );

      if (tsqResponse.tsqTransData == null) {
        state = state.copyWith(
          isLoading: false,
          isTsqTransDataNull: true,
          isTsqChecking: false,
          needsTsqCheck: false,
        );
        doPrinting(context: context, copyType: copyType);
        return;
      }

      state = state.copyWith(
        isLoading: false,
        isTsqChecking: false,
        tsqTransData: tsqResponse.tsqTransData,
        needsTsqCheck: false,
      );
      submitTsqPurchase();
    } catch (error, _) {
      state = state.copyWith(isLoading: false, isTsqChecking: false);
    }
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
    if (state.baseAppResponse.aid == null) {
      context.showToast(message: "Cannot print");
      return;
    }
    if (baseApp == PosPackage.horizon) {
      context.showToast(message: "Printing not available");
    } else {
      final filePath = baseApp == PosPackage.topwise ? topwiseFile : printLogo;
      final data = jsonPrintCardPurchaseV2(
        print: PrintCardPurchase(
          filePath: filePath,
          copyType: copyType,
          appVersionText: "Version $appVersion",
          merchantName: state.baseAppResponse.merchantName ?? '',
          merchantId: state.baseAppResponse.merchantId ?? '',
          terminalId: terminalId ?? '',
          datetime: state.baseAppResponse.datetime ?? '',
          aid: state.baseAppResponse.aid ?? '',
          maskedPan: state.baseAppResponse.maskedPan ?? '',
          stan: state.baseAppResponse.stan ?? '',
          rrn: state.baseAppResponse.rrn ?? '',
          amount: state.baseAppResponse.amount?.formatAmount() ?? '',
          appLabel: state.baseAppResponse.appLabel ?? '',
          message:
              state.purchaseStatusCode == '00'
                  ? 'Approved'
                  : state.baseAppResponse.message ?? '',
        ),
      );
      await startIntentPrinterAndGetResult(
        packageName: "com.globalaccelerex.printer",
        dataKey: "extraData",
        dataValue: jsonEncode(data),
      );

      if (state.isTsqTransDataNull) {
        // at this point, TSQ check has been done and it returned null
        state = state.copyWith(isTsqTransDataNull: false);
        submitPurchase(context);
      }
    }
  }

  Future<void> doPrintingInTsq(String copyType) async {
    final baseApp = ref.watch(baseAppNameProvider);
    final appVersion = ref.read(appVersionProvider);
    final printLogo = ref.watch(printingImageProvider) ?? '';
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    final tsqTransData = state.tsqTransData;
    //
    if (baseApp != PosPackage.topwise) {
      return;
    } else {
      final filePath = baseApp == PosPackage.topwise ? topwiseFile : printLogo;
      final data = jsonPrintCardPurchaseV2(
        print: PrintCardPurchase(
          filePath: filePath,
          copyType: copyType,
          appVersionText: "Version $appVersion",
          merchantName: state.baseAppResponse.merchantName ?? '',
          merchantId: tsqTransData.merchantId ?? '',
          terminalId: terminalId ?? '',
          datetime: tsqTransData.transDate ?? "",
          aid: state.baseAppResponse.aid ?? '',
          maskedPan: tsqTransData.pan ?? '',
          stan: tsqTransData.stan ?? '',
          rrn: tsqTransData.rrn ?? '',
          amount: tsqTransData.amount?.formatAmount() ?? '',
          appLabel: state.baseAppResponse.appLabel ?? '',
          message: tsqTransData.status ?? '',
        ),
      );
      await startIntentPrinterAndGetResult(
        packageName: "com.globalaccelerex.printer",
        dataKey: "extraData",
        dataValue: jsonEncode(data),
      );
    }
  }

  Future<void> submitPurchase(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final acctNo = await AppSecureStorage().getPosNuban();
    final acctName = await AppSecureStorage().getPosNubanName();
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    //
    final quickPurchaseRequest = PosQuickPurchaseRequest(
      amount: num.tryParse(state.baseAppResponse.amount ?? '0') ?? 0,
      maskedPan: state.baseAppResponse.maskedPan ?? "",
      merchantName: acctName ?? "",
      stan: state.baseAppResponse.stan ?? "",
      statusCode: state.baseAppResponse.statuscode ?? "",
      terminalId: terminalId ?? "",
      bankName: state.baseAppResponse.bankName ?? "",
      transactionType: state.baseAppResponse.transactionType ?? "",
      rrn: state.baseAppResponse.rrn ?? "",
      datetime: state.baseAppResponse.datetime ?? "",
      aid: state.baseAppResponse.aid ?? "",
      transactionMessage: state.baseAppResponse.message ?? "",
      merchantCode: state.baseAppResponse.merchantId ?? "",
      merchantNuban: acctNo ?? "",
    );
    //
    bool success = false;
    int retryCount = 0;
    const maxRetries = 3;

    while (!success && retryCount < maxRetries) {
      try {
        await RexApi.instance.posQuickPurchase(
          appVersion: ref.read(appVersionProvider),
          authToken: ref.read(posAuthTokenProvider) ?? '',
          request: quickPurchaseRequest,
        );
        success = true;
      } catch (error, _) {
        retryCount++;
        debugPrintDev('submitPurchase failed, attempt $retryCount...');
        if (retryCount >= maxRetries) {
          state = state.copyWith(isLoading: false);
          context.showToast(
            message: "Transaction submission failed. Please try again.",
          );
          return;
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    //
    state = state.copyWith(isLoading: false, isFromNotif: false);
    context.showToast(message: "Printing...");
    doPrinting(context: context, copyType: 'CUSTOMER COPY');
  }

  Future<void> submitTsqPurchase() async {
    state = state.copyWith(isLoading: true);
    final acctNo = await AppSecureStorage().getPosNuban();
    final acctName = await AppSecureStorage().getPosNubanName();
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    final tsqTransData = state.tsqTransData;
    //
    final quickPurchaseRequest = PosQuickPurchaseRequest(
      amount: tsqTransData.amount.parseToNumSafely(),
      maskedPan: tsqTransData.pan ?? "",
      merchantName: acctName ?? "",
      stan: tsqTransData.stan ?? "",
      statusCode: tsqTransData.responseCode ?? "",
      terminalId: terminalId ?? "",
      bankName: state.baseAppResponse.bankName ?? "",
      transactionType: tsqTransData.transactionType ?? "",
      rrn: tsqTransData.rrn ?? "",
      datetime: tsqTransData.transDate ?? "",
      aid: state.baseAppResponse.aid ?? "",
      transactionMessage: state.baseAppResponse.message ?? "",
      merchantCode: tsqTransData.merchantId ?? "",
      merchantNuban: acctNo ?? "",
    );
    //
    bool success = false;
    int retryCount = 0;
    const maxRetries = 3;

    while (!success && retryCount < maxRetries) {
      try {
        await RexApi.instance.posQuickPurchase(
          appVersion: ref.read(appVersionProvider),
          authToken: ref.read(posAuthTokenProvider) ?? '',
          request: quickPurchaseRequest,
        );
        success = true;
      } catch (error, _) {
        retryCount++;
        debugPrintDev('submitTsqPurchase failed, attempt $retryCount...');
        debugPrintDev('Error: ${error.toString()}');
        if (retryCount >= maxRetries) {
          state = state.copyWith(isLoading: false);
          return;
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    //
    state = state.copyWith(isLoading: false, isFromNotif: false);
    doPrintingInTsq("CUSTOMER COPY");
  }
}
