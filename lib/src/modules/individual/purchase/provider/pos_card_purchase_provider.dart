// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/purchase/model/card_purchase_request.dart';
import 'package:rex_app/src/modules/individual/purchase/model/pos_card_purchase_state.dart';
import 'package:rex_app/src/modules/individual/purchase/model/intent_transaction_response.dart';
import 'package:rex_app/src/modules/individual/purchase/model/pos_card_transaction_type.dart';
import 'package:rex_app/src/modules/individual/purchase/provider/pos_card_method_channel.dart';

final posCardPurchaseProvider =
    NotifierProvider<PosCardPurchaseNotifier, PosCardPurchaseState>(
  PosCardPurchaseNotifier.new,
);

class PosCardPurchaseNotifier extends Notifier<PosCardPurchaseState> {
  @override
  PosCardPurchaseState build() {
    return PosCardPurchaseState(
      transactionResponse: IntentTransactionResponse.empty(),
      purchaseAmount: '',
      purchaseStatusCode: '',
      purchaseMessage: '',
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
    final res = IntentTransactionResponse.fromJson(jsonDecode(result ?? ""));
    state = state.copyWith(
      transactionResponse: res,
      purchaseStatusCode: res.statuscode,
    );
    if (state.transactionResponse.statuscode != null) {
      context
          .push("${RouteName.dashboardIndividual}/${RouteName.purchaseStatus}");
    }
  }
}
