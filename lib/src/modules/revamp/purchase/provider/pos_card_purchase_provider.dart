// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/data/sql/local_db_service.dart';
import 'package:rex_app/src/modules/revamp/pos_device/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/pos_device/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/pos_device/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/printer_json.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_card_purchase_request.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_entity.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/horizon_data.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/pos_card_purchase_state.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';

final posCardPurchaseProvider =
    NotifierProvider<PosCardPurchaseNotifier, PosCardPurchaseState>(
  PosCardPurchaseNotifier.new,
);

class PosCardPurchaseNotifier extends Notifier<PosCardPurchaseState> {
  @override
  PosCardPurchaseState build() {
    return PosCardPurchaseState(
      transactionResponse: BaseAppTransactionResponse.empty(),
      purchaseAmount: '',
      purchaseStatusCode: '',
      purchaseMessage: '',
      loadingApi: false,
    );
  }

  void setPurchaseAmount(String value) {
    state = state.copyWith(purchaseAmount: value);
  }

  Future<void> cardPurchase(BuildContext context) async {
    final intentRequest = BaseAppCardPurchaseRequest(
      transactionType: PosCardTransactionType.purchase.key,
      amount: state.purchaseAmount,
      print: "false",
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

    final res = BaseAppTransactionResponse.fromJson(
      jsonDecode(intentResult ?? ""),
    );
    state = state.copyWith(
      transactionResponse: res,
      purchaseStatusCode: res.statuscode,
    );
    if (state.transactionResponse.statuscode != null) {
      context.push("${Routes.dashboardIndividual}/${Routes.purchaseStatus}");
    }
    savePurchaseToBackend();
  }

  Future<void> printCardTransaction(BuildContext context) async {
    final baseApp = ref.watch(baseAppNameProvider);
    if (state.transactionResponse.aid == null) {
      context.showToast(message: "Cannot print");
      return;
    }
    if (baseApp == PosPackage.horizon) {
      context.showToast(message: "Printing not available");
    } else {
      final filePath = baseApp == PosPackage.topwise
          ? topwiseFilePath
          : ref.watch(printingImageProvider) ?? '';
      final data = getJsonForPrintingCardTransaction(
        state.transactionResponse,
        filePath,
      );
      await startIntentPrinterAndGetResult(
        packageName: "com.globalaccelerex.printer",
        dataKey: "extraData",
        dataValue: jsonEncode(data),
      );
    }
  }

  Future<void> savePurchaseToBackend() async {
    try {
      final authToken = ref.watch(userAuthTokenProvider);
      final accountNumber = ref.watch(userNubanProvider);
      //
      final request = IntentTransactionResult(
        aid: state.transactionResponse.aid ?? "",
        amount: state.transactionResponse.amount ?? "",
        appLabel: state.transactionResponse.appLabel ?? "",
        authcode: state.transactionResponse.authcode ?? "",
        bankLogo: state.transactionResponse.bankLogo ?? "",
        bankName: state.transactionResponse.bankName ?? "",
        baseAppVersion: state.transactionResponse.baseAppVersion ?? "",
        cardExpireDate: state.transactionResponse.cardExpireDate ?? "",
        cardHolderName: state.transactionResponse.cardHolderName ?? "",
        currency: state.transactionResponse.currency ?? "",
        datetime: state.transactionResponse.datetime ?? "",
        footerMessage: state.transactionResponse.footerMessage ?? "",
        maskedPan: state.transactionResponse.maskedPan ?? "",
        merchantAddress: state.transactionResponse.merchantAddress ?? "",
        merchantCategoryCode:
            state.transactionResponse.merchantCategoryCode ?? "",
        merchantId: state.transactionResponse.merchantId ?? "",
        merchantName: state.transactionResponse.merchantName ?? "",
        message: state.transactionResponse.message ?? "",
        nuban: accountNumber,
        pinType: state.transactionResponse.pinType ?? "",
        posEntryMode: "",
        ptsp: state.transactionResponse.ptsp ?? "",
        rrn: state.transactionResponse.rrn ?? "",
        stan: state.transactionResponse.stan ?? "",
        statuscode: state.transactionResponse.statuscode ?? "",
        terminalID: state.transactionResponse.terminalId ?? "",
        transactionType: state.transactionResponse.transactionType ?? "",
      );
      //
      await RexApi.instance.cardPurchaseApi(
        request: request,
        authToken: authToken ?? "",
      );
      await saveCardPurchaseToLocalDb(true);
    } catch (error, _) {
      saveCardPurchaseToLocalDb(false);
    }
  }

  Future<void> saveCardPurchaseToLocalDb(bool apiSuccess) async {
    final accountNumber = ref.watch(userNubanProvider);
    final dbService = LocalDbService();
    //
    final entity = BaseappTransactionEntity(
      aid: state.transactionResponse.aid ?? "",
      amount: state.transactionResponse.amount ?? "",
      appLabel: state.transactionResponse.appLabel ?? "",
      authcode: state.transactionResponse.authcode ?? "",
      bankLogo: state.transactionResponse.bankLogo ?? "",
      bankName: state.transactionResponse.bankName ?? "",
      baseAppVersion: state.transactionResponse.baseAppVersion ?? "",
      cardExpireDate: state.transactionResponse.cardExpireDate ?? "",
      cardHolderName: state.transactionResponse.cardHolderName ?? "",
      currency: state.transactionResponse.currency ?? "",
      dateAndTime: state.transactionResponse.datetime ?? "",
      footerMessage: state.transactionResponse.footerMessage ?? "",
      maskedPan: state.transactionResponse.maskedPan ?? "",
      merchantAddress: state.transactionResponse.merchantAddress ?? "",
      merchantCategoryCode:
          state.transactionResponse.merchantCategoryCode ?? "",
      merchantId: state.transactionResponse.merchantId ?? "",
      merchantName: state.transactionResponse.merchantName ?? "",
      message: state.transactionResponse.message ?? "",
      nuban: accountNumber,
      pinType: state.transactionResponse.pinType ?? "",
      ptsp: state.transactionResponse.ptsp ?? "",
      rrn: state.transactionResponse.rrn ?? "",
      stan: state.transactionResponse.stan ?? "",
      statuscode: state.transactionResponse.statuscode ?? "",
      terminalId: state.transactionResponse.terminalId ?? "",
      transactionType: state.transactionResponse.transactionType ?? "",
      cashBackAmount: state.transactionResponse.cashBackAmount ?? "",
      ptspContact: state.transactionResponse.ptspContact ?? "",
      deviceSerialNumber: state.transactionResponse.deviceSerialNumber ?? "",
    );
    //
    if (apiSuccess) {
      await dbService.insertSuccessTransaction(entity);
    } else {
      await dbService.insertFailedTransaction(entity);
    }
  }
}
