// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_eod.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/reprint_eod/model/eod_pagination_state.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/eod_mixin.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_date_time.dart';

final eodPaginationProvider =
    NotifierProvider<EodPaginationNotifier, EodPaginationState>(
      EodPaginationNotifier.new,
    );

class EodPaginationNotifier extends Notifier<EodPaginationState> with EodMixin {
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
    final config = AppKeysStorage.getConfig();
    final reprintState = ref.watch(reprintProvider);
    //
    final request = PosTransactionsRequest(
      orderType: "descending",
      pageSize: state.pageSize,
      pageIndex: state.pageIndex,
      startDate: reprintState.todaysDate,
      endDate: reprintState.todaysDate,
      accountNo: config.baasNuban,
    );
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.authToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    try {
      final apiResponse = await RexApi.instance.posTransactions(
        header: header,
        request: request,
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
    if (state.dataList.isEmpty) {
      context.showSnack(message: "Nothing to print");
      return;
    }
    state = state.copyWith(overlayLoading: true);
    final config = AppKeysStorage.getConfig();
    final filePath = config.printImage;
    final baseAppName = config.baseappName;
    final reprintState = ref.watch(reprintProvider);
    //
    final eodLines = transformToLineDataFast(state.dataList);
    final totalSales = getTotalSales(state.dataList);
    final countSuccess = countStatus(state.dataList, 'successful');
    final countFailed = countStatus(state.dataList, 'failed');
    final nowDate = DateTime.now();
    final terminalId = config.baasTerminalId;
    final merchantId = config.merchantId;
    final merchantName = config.baasNubanName;
    final appVersionText =
        ApiConfig.shared.flavor == ApiFlavor.dev
            ? "RexAfricaDev ${config.appVersionLocal}"
            : "RexAfrica ${config.appVersionLocal}";
    //
    if (terminalId.isEmpty || merchantId.isEmpty) {
      context.showSnack(message: 'Download settings. ID not detected');
    }
    //
    final eodReportData = EODReportData(
      bitmapPath:
          (baseAppName == Pkg.topwise || baseAppName == Pkg.topwise2)
              ? topwiseFile
              : filePath,
      date: nowDate.dateReadable(),
      time: nowDate.timeIn24hrs(),
      merchantName: "[$merchantName]",
      eodDate: reprintState.todaysDate,
      terminalId: terminalId,
      merchantId: merchantId,
      lines: eodLines,
      totalTx: state.dataList.length,
      successfulTx: countSuccess,
      failedTx: countFailed,
      totalSales: "NGN $totalSales",
      appVersion: appVersionText,
    );
    final eodReportJson = getJsonForEODv2(eodReportData);
    state = state.copyWith(overlayLoading: false);
    //
    switch (baseAppName) {
      case Pkg.nexgo:
      case Pkg.nexgorex:
      case Pkg.telpo:
      case Pkg.topwise:
      case Pkg.topwise2:
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(eodReportJson),
        );
        break;
      case Pkg.horizon:
        context.showSnack(message: 'Printing not available');
        break;
      case Pkg.none:
        context.showSnack(message: "Cannot identify device");
        break;
      default:
    }
  }
}
