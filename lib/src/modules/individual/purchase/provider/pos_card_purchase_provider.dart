// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/purchase/model/card_purchase_request.dart';
import 'package:rex_app/src/modules/individual/purchase/model/pos_card_purchase_state.dart';
import 'package:rex_app/src/modules/individual/purchase/model/intent_transaction_response.dart';
import 'package:rex_app/src/modules/individual/purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/individual/purchase/provider/pos_card_method_channel.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';

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
    final request = CardPurchaseRequest(
      transactionType: PosCardTransactionType.purchase.key,
      amount: state.purchaseAmount,
      print: "false",
    );
    final result = await startIntentAndGetResult(
      packageName: "com.globalaccelerex.transaction",
      extraData: '${request.toJson()}',
    );
    final res = BaseAppTransactionResponse.fromJson(jsonDecode(result ?? ""));
    state = state.copyWith(
      transactionResponse: res,
      purchaseStatusCode: res.statuscode,
    );
    if (state.transactionResponse.statuscode != null) {
      context
          .push("${RouteName.dashboardIndividual}/${RouteName.purchaseStatus}");
    }
  }

  Future<void> savePurchaseToBackend(BuildContext context) async {
    state = state.copyWith(loadingApi: true);
    try {
      final authToken = ref.watch(userAuthTokenProvider);
      final accountNumber = ref.watch(userNubanProvider);
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
    }
  }
}
