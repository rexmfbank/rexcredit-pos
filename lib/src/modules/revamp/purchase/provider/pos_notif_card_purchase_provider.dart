// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_models/json_card_purchase.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/print_models/print_card_purchase.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_card_purchase_request.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/horizon_data.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/pos_notif_card_purchase_state.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final posNotifCardPurchaseProvider =
    NotifierProvider<PosNotifCardPurchaseNotifier, PosNotifCardPurchaseState>(
      PosNotifCardPurchaseNotifier.new,
    );

class PosNotifCardPurchaseNotifier extends Notifier<PosNotifCardPurchaseState> {
  final tsqCheckCodes = {'91', '96'};

  @override
  PosNotifCardPurchaseState build() {
    return PosNotifCardPurchaseState(
      baseAppResponse: BaseAppTransResponse.empty(),
      tsqTransData: TsqTransactionData.empty(),
      purchaseStatusCode: '',
      purchaseMessage: '',
      isLoading: false,
      isQuickPurchase: false,
      isButtonEnabled: true,
      isTsqTransDataNull: false,
      isPrintingDone: false,
      isTsqChecking: false,
      needsTsqCheck: false,
      posNotifAmount: '',
      posNotifTerminalSerialNo: '',
      posNotifRrn: '',
      posNotifStan: '',
      posNotifInvoiceId: '',
    );
  }

  void setData({required PosNotification data}) {
    debugPrintDev('INSIDE SET DATA FOR NOTIF PURCHASE');
    state = state.copyWith(
      posNotifAmount: data.amount,
      posNotifTerminalSerialNo: data.terminalSerialNo,
      posNotifRrn: data.rrn,
      posNotifStan: data.stan,
      posNotifInvoiceId: data.invoiceId,
    );
  }

  /*void initDataForNotifPurchase({
    required PosNotification data,
    required BuildContext context,
  }) {
    state = state.copyWith(
      posNotifAmount: data.amount,
      posNotifTerminalSerialNo: data.terminalSerialNo,
      posNotifRrn: data.rrn,
      posNotifStan: data.stan,
      posNotifInvoiceId: data.invoiceId,
    );
    doCardPurchase(context: context);
  }*/

  Future<void> doCardPurchase({required BuildContext context}) async {
    final intentRequest = BaseAppCardPurchaseRequest(
      transactionType: PosCardTransactionType.purchase.key,
      amount: state.posNotifAmount,
      print: "false",
      rrn: state.posNotifRrn,
      stan: state.posNotifStan,
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

    final res = BaseAppTransResponse.fromJson(jsonDecode(intentResult ?? ""));
    state = state.copyWith(
      baseAppResponse: res,
      purchaseStatusCode: res.statuscode,
    );
    context.push(Routes.quickPurchaseStatus);

    if (tsqCheckCodes.contains(state.purchaseStatusCode)) {
      state = state.copyWith(needsTsqCheck: true);
      doTsqCheck(context, 'CUSTOMER COPY');
    } else {
      state = state.copyWith(needsTsqCheck: false);
      submitPurchase(context);
    }
  }

  Future<void> doTsqCheck(BuildContext context, String copyType) async {
    state = state.copyWith(isLoading: true, isTsqChecking: true);
    try {
      final tsqResponse = await RexApi.instance.posTsqCheck(
        appVersion: ref.read(appVersionProvider),
        authToken: ref.read(posAuthTokenProvider) ?? '',
        rrn: state.posNotifRrn,
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
    state = state.copyWith(isLoading: false);
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
    state = state.copyWith(isLoading: false);
    doPrintingInTsq("CUSTOMER COPY");
  }
}
