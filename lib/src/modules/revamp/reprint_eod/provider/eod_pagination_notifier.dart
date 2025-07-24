import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_eod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_eod2.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_test_printer.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/model/eod_pagination_state.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

final eodPaginationProvider =
    NotifierProvider<EodPaginationNotifier, EodPaginationState>(
      EodPaginationNotifier.new,
    );

class EodPaginationNotifier extends Notifier<EodPaginationState> {
  @override
  EodPaginationState build() {
    return EodPaginationState();
  }

  Future<void> initialize() async {
    if (!state.isInitialized) {
      state = state.copyWith(isInitialized: true);
      Future.microtask(() => fetch());
    }
  }

  Future<void> fetch() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    //
    final authToken = ref.watch(posAuthTokenProvider);
    final appVersion = ref.watch(appVersionProvider);
    final reprintState = ref.watch(reprintProvider);
    try {
      final apiResponse = await RexApi.instance.posTransactions(
        authToken: authToken ?? '',
        appVersion: appVersion,
        request: PosTransactionsRequest(
          orderType: "descending",
          pageSize: state.pageSize,
          pageIndex: state.pageIndex,
          startDate: reprintState.todaysDate,
          endDate: reprintState.todaysDate,
        ),
      );
      if (apiResponse.responseCode == '000') {
        final newItems = apiResponse.data;
        List<PosTransactionsResponseData> updatedList;
        if (state.isRefresh || state.pageIndex == 1) {
          updatedList = newItems;
        } else {
          updatedList = [...state.dataList, ...newItems];
        }
        state = state.copyWith(
          pageIndex: state.pageIndex + 1,
          isLoading: false,
          hasMore:
              newItems.length >= state.pageSize &&
              apiResponse.hasNextPage == true &&
              state.pageIndex <= apiResponse.totalPages,
          dataList: updatedList,
        );
      } else {
        state = state.copyWith(isLoading: false, hasMore: false);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isRefresh: true,
      isLoading: false,
      hasMore: true,
      pageIndex: 1,
    );
    state = state.copyWith(isFiltered: false);
    await fetch();
    state = state.copyWith(isRefresh: false);
  }

  bool get shouldShowLoading {
    return state.isLoading && state.dataList.isNotEmpty && !state.isRefresh;
  }

  bool get shouldShowEndOfList {
    return !state.isLoading && !state.hasMore && state.dataList.isNotEmpty;
  }

  Future<void> printEOD(BuildContext context) async {
    // if (state.dataList.isEmpty) {
    //   context.showToast(message: "Nothing to print");
    //   return;
    // }
    final filePath = ref.watch(printingImageProvider) ?? '';
    final baseAppName = ref.watch(baseAppNameProvider);
    //
    List<EODTransactionLine> eodlines = [
      EODTransactionLine(
        index: 0,
        type: 'CARD',
        amount: '1,500',
        timeHHMM: '12:03',
        stan: '001200',
      ),
      EODTransactionLine(
        index: 1,
        type: 'TRANSFER',
        amount: '2,400',
        timeHHMM: '04:32',
        stan: '002300',
      ),
      EODTransactionLine(
        index: 2,
        type: 'CARD',
        amount: '4,000',
        timeHHMM: '03:20',
        stan: '003400',
      ),
    ];
    //
    final nowDate = DateTime.now();
    final nowDateString = nowDate.dateReadable();
    final data = EODReportData(
      bitmapPath: filePath,
      date: nowDateString,
      time: nowDate.timeIn24hrs(),
      merchantName: "[Merchant Business Name]",
      terminalId: "01234567",
      merchantId: "03456789",
      lines: eodlines,
      totalTx: 18,
      successfulTx: 10,
      failedTx: 8,
      totalSales: "NGN 150,000",
    );
    final eodData = getJsonForEODv2(data);
    //
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
        // final data = getJsonForEOD(
        //   filePath: filePath,
        //   nowDate: nowDateString,
        //   nowTime: "",
        // );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(eodData),
        );
        break;
      case PosPackage.topwise:
        final data = getJsonForEOD(
          filePath: topwiseFile,
          nowDate: nowDateString,
          nowTime: "",
        );
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(data),
        );
        break;
      case PosPackage.horizon:
        context.showToast(message: 'Printing not available');
        break;
      case PosPackage.none:
        context.showToast(message: "Cannot identify device");
        break;
      default:
    }
  }
}

const topwiseFile =
    'https://res.cloudinary.com/dpepsmzmw/image/upload/v1749626258/rex_logo_2_pz5iju.png';
