import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_card_method_channel.dart';
import 'package:rex_app/src/modules/individual/reprinting/model/reprint_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

final reprintProvider = NotifierProvider<ReprintNotifier, ReprintState>(
  ReprintNotifier.new,
);

class ReprintNotifier extends Notifier<ReprintState> {
  @override
  ReprintState build() {
    return ReprintState(
      todaysDate: DateTime.now().dateYYYYMMDD(),
      transactionList: [],
      todaysList: [],
    );
  }

  Future<void> fetchTransactionList() async {
    final authToken = ref.watch(userAuthTokenProvider);
    final nuban = ref.watch(userNubanProvider);
    final entityCode = ref.watch(userEntityCodeProvider);
    //
    final request = MiniStatementRequest(
      accountNo: nuban,
      entityCode: entityCode,
      pageIndex: 1,
      pageSize: 10,
      tranCode: '',
      startDate: '',
      endDate: '',
    );
    final res = await RexApi.instance.fetchMiniStatement(
      authToken: authToken ?? '',
      request: request,
    );
    state = state.copyWith(transactionList: res.data);
    updateTodaysList();
  }

  void updateTodaysList() {
    final tList = state.transactionList.where(
      (value) => value.transactionDate?.dateYYYYMMDD() == state.todaysDate,
    );
    state = state.copyWith(todaysList: tList.toList());
  }

  Future<void> printEOD(BuildContext context) async {
    final value = ref.watch(printingImageProvider);
    for (final data in state.todaysList) {
      sendToPrintTransferDetail(data, value ?? '');
    }
  }
}
