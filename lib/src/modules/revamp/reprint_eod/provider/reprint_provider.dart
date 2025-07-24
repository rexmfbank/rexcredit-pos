import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/printer_json3.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/model/reprint_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
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
    state = state.copyWith(todaysDate: date.dateDDMMYYYY());
  }

  void setPosTransactList(List<PosTransactionsResponseData> list) {
    state = state.copyWith(posTransactList: list);
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

  void printEODv2(
    BuildContext context,
    List<PosTransactionsResponseData> list,
  ) {
    //final eodList = ref.watch(eodTransactionsProvider).asData?.value ?? [];
    // if (eodList.isEmpty) {
    //   context.showToast(message: 'Empty list. Nothing to print');
    // }
    for (final data in list) {
      printQuickTransactionDetail(context: context, data: data);
    }
  }

  void printQuickTransactionDetail({
    required PosTransactionsResponseData data,
    required BuildContext context,
  }) async {
    final baseAppName = ref.watch(baseAppNameProvider);
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
        final dataJson = getJsonForPrintingQuickTransactionDetail(
          data,
          ref.watch(printingImageProvider) ?? '',
        );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case PosPackage.topwise:
        final dataJson = getJsonForPrintingQuickTransactionDetail(
          data,
          topwiseFilePath,
        );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(dataJson),
        );
        break;
      case PosPackage.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosPackage.none:
        context.showToast(message: "Cannot identify device");
        break;
    }
  }
}
