import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/reprint_eod/model/reprint_state.dart';
import 'package:rex_app/src/utils/app_keys.dart';
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
      posTransactList: [],
    );
  }

  void setTodaysDate(DateTime date) {
    state = state.copyWith(todaysDate: date.dateYYYYMMDD());
  }

  void setPosTransactList(List<PosTransactionsResponseData> list) {
    state = state.copyWith(posTransactList: list);
  }

  Future<void> fetchTransactionList() async {
    final config = AppKeysStorage.getConfig();
    //
    final request = MiniStatementRequest(
      accountNo: config.baasNuban,
      entityCode: 'RMB',
      pageIndex: 1,
      pageSize: 10,
      tranCode: '',
      startDate: '',
      endDate: '',
    );
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.authToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );

    final res = await RexApi.instance.fetchMiniStatement(
      header: header,
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
          .printTransactionDetailInApp(context, data);
    }
  }
}
