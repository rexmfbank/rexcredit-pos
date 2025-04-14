// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/data/sql/local_db_service.dart';
import 'package:rex_app/src/modules/individual/purchase/model/baseapp_card_purchase_request.dart';
import 'package:rex_app/src/modules/individual/purchase/model/baseapp_transaction_entity.dart';
import 'package:rex_app/src/modules/individual/purchase/model/pos_card_purchase_state.dart';
import 'package:rex_app/src/modules/individual/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/individual/purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/individual/purchase/provider/pos_card_method_channel.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

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
    final intentResult = await startIntentAndGetResult(
      packageName: "com.globalaccelerex.transaction",
      extraData: '${intentRequest.toJson()}',
    );
    //
    debugPrint("CARD PURCHASE INTENT RESULT: $intentResult");
    final res = BaseAppTransactionResponse.fromJson(
      jsonDecode(intentResult ?? ""),
    );
    debugPrint("BaseAppTransactionResponse: $res");
    state = state.copyWith(
      transactionResponse: res,
      purchaseStatusCode: res.statuscode,
    );
    if (state.transactionResponse.statuscode != null) {
      context
          .push("${RouteName.dashboardIndividual}/${RouteName.purchaseStatus}");
    }
  }

  Future<void> printCardTransaction(BuildContext context) async {
    if (state.transactionResponse.aid == null) {
      context.showToast(message: "Cannot print");
    } else {
      sendToPrintCardTransaction(state.transactionResponse);
    }
  }

  Future<void> savePurchaseToBackend(BuildContext context) async {
    state = state.copyWith(loadingApi: true);
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
      state = state.copyWith(loadingApi: false);
      showModalActionSuccess(
        context: context,
        subtitle: 'Transaction Saved',
        onPressed: () {
          context.go(RouteName.dashboardIndividual);
        },
      );
    } catch (error, _) {
      state = state.copyWith(loadingApi: false);
      // save to local Database
      showModalActionError(
        context: context,
        errorText: 'Unable to save transaction',
        onTap: () async {
          await savePurchaseToLocalDb();
          context.go(RouteName.dashboardIndividual);
        },
      );
    }
  }

  Future<void> savePurchaseToLocalDb() async {
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
    await dbService.insertTransaction(entity);
  }
}
