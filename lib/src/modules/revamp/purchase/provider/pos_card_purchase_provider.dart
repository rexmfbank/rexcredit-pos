// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
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
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final posCardPurchaseProvider =
    NotifierProvider<PosCardPurchaseNotifier, PosCardPurchaseState>(
      PosCardPurchaseNotifier.new,
    );

class PosCardPurchaseNotifier extends Notifier<PosCardPurchaseState> {
  final battery = Battery();

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
      rrnNumber: '',
      stanNumber: '',
    );
  }

  void setPurchaseAmount(String value) {
    state = state.copyWith(purchaseAmount: value);
  }

  Future<void> doInputValidation({
    required BuildContext context,
    required bool quickPurchase,
  }) async {
    state = state.copyWith(isQuickPurchase: quickPurchase);
    final number = num.tryParse(state.purchaseAmount);
    final posAuthToken = ref.watch(posAuthTokenProvider) ?? '';
    final batteryLevel = await battery.batteryLevel;
    //
    if (quickPurchase && posAuthToken.isEmpty) {
      context.showToast(message: "Identifcation failed. Download settings");
      return;
    } else if (number == 0) {
      context.showToast(message: "Transaction amount must be greater than ₦0");
      return;
    } else if (state.purchaseAmount.isEmpty ||
        state.purchaseAmount.startsWith('0')) {
      context.showToast(message: 'Input a valid amount');
      return;
    } else if (!await ConnectionCheck.isConnected()) {
      context.showToast(message: 'Internet connection lost!');
      return;
    } else if (batteryLevel < 20) {
      context.showToast(message: "Device battery is low. Cannot Proceed");
      return;
    } else {
      doRrnRetrieval(context: context, quickPurchase: quickPurchase);
    }
  }

  Future<void> doRrnRetrieval({
    required BuildContext context,
    required bool quickPurchase,
  }) async {
    state = state.copyWith(isLoading: true, isButtonEnabled: false);
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
        isButtonEnabled: true,
      );
      doCardPurchase(context: context, quickPurchase: quickPurchase);
    } catch (e) {
      context.showToast(message: "Please try again");
      state = state.copyWith(isLoading: false, isButtonEnabled: true);
    }
  }

  Future<void> doCardPurchase({
    required BuildContext context,
    required bool quickPurchase,
  }) async {
    final intentRequest = BaseAppCardPurchaseRequest(
      transactionType: PosCardTransactionType.purchase.key,
      amount: state.purchaseAmount,
      print: "false",
      rrn: state.rrnNumber,
      stan: state.stanNumber,
    );
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
    state = state.copyWith(purchaseAmount: '');
    final res = BaseAppTransResponse.fromJson(jsonDecode(intentResult ?? ""));
    state = state.copyWith(
      baseAppResponse: res,
      purchaseStatusCode: res.statuscode,
      isButtonEnabled: true,
    );
    //
    if (quickPurchase) {
      context.push(Routes.quickPurchaseStatus);
    } else {
      context.push("${Routes.dashboardIndividual}/${Routes.purchaseStatus}");
    }
    state.purchaseStatusCode == '00'
        ? submitPurchase()
        : doTsqCheck(context, 'CUSTOMER COPY');
  }

  Future<void> doTsqCheck(BuildContext context, String copyType) async {
    state = state.copyWith(isLoading: true, isTsqChecking: true);
    try {
      final tsqResponse = await RexApi.instance.posTsqCheck(
        appVersion: ref.read(appVersionProvider),
        authToken: ref.read(posAuthTokenProvider) ?? '',
        rrn: state.rrnNumber,
      );
      debugPrint("TSQ API Response: $tsqResponse ");
      debugPrint("TSQ API Response Data: ${tsqResponse.tsqTransData}");

      if (tsqResponse.tsqTransData == null) {
        debugPrint("TSQ Trans Data is null");
        state = state.copyWith(
          isLoading: false,
          isTsqTransDataNull: true,
          isTsqChecking: false,
        );
        doPrinting(context: context, copyType: copyType);
        return;
      }

      state = state.copyWith(
        isLoading: false,
        isTsqChecking: false,
        tsqTransData: tsqResponse.tsqTransData,
      );
      debugPrint("TSQ Notifier State: ${state.tsqTransData}");
      submitTsqPurchase();
    } catch (error, stackTrace) {
      debugPrint("Error in doTsqCheck: $error");
      debugPrint("Stacktrace in doTsqCheck: $stackTrace");
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
        submitPurchase();
      }
    }
  }

  Future<void> doPrintingInTsq({
    required BuildContext context,
    required String copyType,
  }) async {
    final baseApp = ref.watch(baseAppNameProvider);
    final appVersion = ref.read(appVersionProvider);
    final printLogo = ref.watch(printingImageProvider) ?? '';
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    final tsqTransData = state.tsqTransData;
    //
    if (baseApp != PosPackage.topwise) {
      context.showToast(message: "Printing not available");
    } else {
      final filePath = baseApp == PosPackage.topwise ? topwiseFile : printLogo;
      final data = jsonPrintCardPurchaseV2(
        print: PrintCardPurchase(
          filePath: filePath,
          copyType: copyType,
          appVersionText: "Version $appVersion",
          merchantName: tsqTransData.merchantName ?? '',
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

  Future<void> submitPurchase() async {
    debugPrint("Submitting Purchase to the Backend");
    state = state.copyWith(isLoading: true);
    final acctNo = await AppSecureStorage().getPosNuban();
    final acctName = await AppSecureStorage().getPosNubanName();
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    try {
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
      await RexApi.instance.posQuickPurchase(
        appVersion: ref.read(appVersionProvider),
        authToken: ref.read(posAuthTokenProvider) ?? '',
        request: quickPurchaseRequest,
      );
      state = state.copyWith(isLoading: false);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> submitTsqPurchase() async {
    debugPrint("Submitting TSQ Purchase to the Backend");
    state = state.copyWith(isLoading: true);
    final acctNo = await AppSecureStorage().getPosNuban();
    final acctName = await AppSecureStorage().getPosNubanName();
    final terminalId = await AppSecureStorage().getBaasTerminalId();
    final tsqTransData = state.tsqTransData;
    //
    try {
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
      debugPrint("TSQ Quick Purchase Request: $quickPurchaseRequest");
      await RexApi.instance.posQuickPurchase(
        appVersion: ref.read(appVersionProvider),
        authToken: ref.read(posAuthTokenProvider) ?? '',
        request: quickPurchaseRequest,
      );
      state = state.copyWith(isLoading: false);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
    }
  }
}
