// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_eod2.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/model/eod_pagination_state.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/provider/eod_mixin.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/secure_storage.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

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
    if (state.dataList.isEmpty) {
      context.showToast(message: "Nothing to print");
      return;
    }
    state = state.copyWith(overlayLoading: true);
    final filePath = ref.watch(printingImageProvider) ?? '';
    final baseAppName = ref.watch(baseAppNameProvider);
    final reprintState = ref.watch(reprintProvider);
    //
    final eodLines = transformToLineDataFast(state.dataList);
    final totalSales = getTotalSales(state.dataList);
    final countSuccess = countStatus(state.dataList, 'successful');
    final countFailed = countStatus(state.dataList, 'failed');
    final nowDate = DateTime.now();
    //
    final terminalId = await SecureStorage().getPosTerminalId();
    final merchantId = await SecureStorage().getPosMerchantId();
    final merchantName = await SecureStorage().getPosNubanName();
    if (terminalId == null ||
        terminalId.isEmpty ||
        merchantId == null ||
        merchantId.isEmpty) {
      context.showToast(message: 'Download settings. ID not detected');
    }
    //
    final eodReportData = EODReportData(
      bitmapPath: baseAppName == PosPackage.topwise ? topwiseFile : filePath,
      date: nowDate.dateReadable(),
      time: nowDate.timeIn24hrs(),
      merchantName: "[$merchantName]",
      eodDate: reprintState.todaysDate,
      terminalId: terminalId!,
      merchantId: merchantId!,
      lines: eodLines,
      totalTx: state.dataList.length,
      successfulTx: countSuccess,
      failedTx: countFailed,
      totalSales: "NGN $totalSales",
    );
    final eodReportJson = getJsonForEODv2(eodReportData);
    state = state.copyWith(overlayLoading: false);
    //
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
      case PosPackage.topwise:
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          dataValue: jsonEncode(eodReportJson),
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

  /*Future<void> printEOD(BuildContext context) async {
    if (state.dataList.isEmpty) {
      context.showToast(message: "Nothing to print");
      return;
    }
    final filePath = ref.watch(printingImageProvider) ?? '';
    final baseAppName = ref.watch(baseAppNameProvider);
    final nowDate = DateTime.now();
    final terminalId = await SecureStorage().getPosTerminalId();
    final merchantId = await SecureStorage().getPosMerchantId();
    final merchantName = await SecureStorage().getPosNubanName();
    if (terminalId == null ||
        terminalId.isEmpty ||
        merchantId == null ||
        merchantId.isEmpty) {
      context.showToast(message: 'Download settings. ID not detected');
      return;
    }
    state = state.copyWith(overlayLoading: true);
    final prepared = await compute<PrepareParams, PrepareResult>(
      prepareEodPayload,
      PrepareParams(
        txs: state.dataList,
        eodDate: ref.read(reprintProvider).todaysDate,
        dateString: nowDate.dateReadable(),
        timeString: nowDate.timeIn24hrs(),
        bitmapPath: baseAppName == PosPackage.topwise ? topwiseFile : filePath,
        merchantName: "[$merchantName]",
        terminalId: terminalId,
        merchantId: merchantId,
      ),
    );
    state = state.copyWith(overlayLoading: true);
    //
    switch (baseAppName) {
      case PosPackage.nexgo:
      case PosPackage.nexgorex:
      case PosPackage.telpo:
      case PosPackage.topwise:
        await startIntentPrinterAndGetResult(
          packageName: "com.globalaccelerex.printer",
          dataKey: "extraData",
          //dataValue: jsonEncode(eodReportJson),
          dataValue: jsonEncode(prepared.jsonPayload),
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
  }*/

  PrepareResult prepareEodPayload(PrepareParams p) {
    final lines = transformToLineDataFast(p.txs);
    final total = getTotalSales(p.txs);
    final ok = countStatus(p.txs, 'successful');
    final fail = countStatus(p.txs, 'failed');

    final data = EODReportData(
      bitmapPath: p.bitmapPath,
      date: p.dateString,
      time: p.timeString,
      merchantName: p.merchantName,
      eodDate: p.eodDate,
      terminalId: p.terminalId,
      merchantId: p.merchantId,
      lines: lines,
      totalTx: state.dataList.length,
      successfulTx: ok,
      failedTx: fail,
      totalSales: "NGN $total",
    );
    return PrepareResult(
      lines: lines,
      totalSales: total,
      okCount: ok,
      failCount: fail,
      jsonPayload: getJsonForEODv2(data),
    );
  }
}

const topwiseFile =
    'https://res.cloudinary.com/dpepsmzmw/image/upload/v1749626258/rex_logo_2_pz5iju.png';
