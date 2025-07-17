import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/reprinting/model/reprint_state.dart';
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
    final authToken = ref.watch(appAuthTokenProvider);
    final nuban = ref.watch(userNubanProvider);
    //
    final request = MiniStatementRequest(
      accountNo: nuban,
      entityCode: 'RMB',
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

  void printEOD(BuildContext context) {
    for (final data in state.todaysList) {
      ref
          .read(posGlobalProvider.notifier)
          .printTransactionDetail(context, data);
    }
  }
}
