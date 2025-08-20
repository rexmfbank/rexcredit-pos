import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/model/pos_pagination_state.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_filter_notifier.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_trans_date_notifier.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/secure_storage.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final posPaginationProvider =
    NotifierProvider<PosPaginationNotifier, PosPaginationState>(
      PosPaginationNotifier.new,
    );

class PosPaginationNotifier extends Notifier<PosPaginationState> {
  @override
  PosPaginationState build() {
    return PosPaginationState();
  }

  Future<void> initialize() async {
    if (!state.isInitialized) {
      state = state.copyWith(isInitialized: true);
      Future.microtask(() => fetch());
    }
  }

  Future<void> fetch() async {
    // Check if any filter is applied OR search query exists
    if (state.isFiltered || state.searchQuery.isNotEmpty) {
      await _fetchWithFiltersAndSearch();
      return;
    }
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    //
    final authToken = ref.watch(posAuthTokenProvider);
    final appVersion = ref.watch(appVersionProvider);
    final acctNo = await SecureStorage().getPosNuban();
    try {
      final apiResponse = await RexApi.instance.posTransactions(
        authToken: authToken ?? '',
        appVersion: appVersion,
        request: PosTransactionsRequest(
          orderType: "descending",
          pageSize: state.pageSize,
          pageIndex: state.pageIndex,
          accountNo: acctNo,
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
          filteredList: updatedList,
        );
      } else {
        state = state.copyWith(isLoading: false, hasMore: false);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchWithFiltersAndSearch() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    final authToken = ref.read(posAuthTokenProvider);
    final appVersion = ref.watch(appVersionProvider);
    final acctNo = await SecureStorage().getPosNuban();
    final pDate = ref.watch(posTransDateProvider);
    //
    try {
      final res = await RexApi.instance.posTransactions(
        authToken: authToken ?? '',
        appVersion: appVersion,
        request: PosTransactionsRequest(
          orderType: "descending",
          pageIndex: state.pageIndex,
          pageSize: state.pageSize,
          startDate: pDate.dateToNull ? '' : state.startDate,
          endDate: pDate.dateToNull ? '' : state.endDate,
          status: state.status,
          transactionType: state.transactionType,
          tranDesc: state.searchQuery,
          accountNo: acctNo,
        ),
      );

      if (res.responseCode == '000') {
        final newItems = res.data;
        List<PosTransactionsResponseData> updatedDataList;

        if (state.pageIndex == 1) {
          updatedDataList = newItems;
        } else {
          updatedDataList = [...state.dataList, ...newItems];
        }

        state = state.copyWith(
          dataList: updatedDataList,
          filteredList: updatedDataList,
          pageIndex: state.pageIndex + 1,
          isLoading: false,
          hasMore:
              newItems.length >= state.pageSize &&
              res.hasNextPage == true &&
              state.pageIndex <= res.totalPages,
        );
      } else {
        state = state.copyWith(
          dataList: [],
          filteredList: [],
          isLoading: false,
          hasMore: false,
        );
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> applyFilters({
    String? startDate,
    String? endDate,
    String? status,
    String? transactionType,
  }) async {
    final hasFilters =
        (startDate?.isNotEmpty ?? false) ||
        (endDate?.isNotEmpty ?? false) ||
        (status?.isNotEmpty ?? false) ||
        (transactionType?.isNotEmpty ?? false);

    state = state.copyWith(
      filteredList: [],
      isLoading: false,
      pageIndex: 1,
      dataList: [],
      isFiltered: hasFilters,
      hasMore: true,
      startDate: startDate,
      endDate: endDate,
      status: status ?? '',
      transactionType: transactionType ?? '',
    );

    await _fetchWithFiltersAndSearch();
  }

  Future<void> applySearch(String query) async {
    state = state.copyWith(
      searchQuery: query,
      pageIndex: 1,
      dataList: [],
      filteredList: [],
      hasMore: true,
    );
    await _fetchWithFiltersAndSearch();
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isRefresh: true,
      isLoading: false,
      hasMore: true,
      pageIndex: 1,
    );
    // Clear all filter
    ref.read(posTransDateProvider.notifier).setDatesToNull();
    ref.read(posFilterTransTypeProvider.notifier).state =
        PosFilterTransType.all;
    ref.read(posFilterTransStatusProvider.notifier).state =
        PosFilterTransStatus.all;

    // Reset filter states
    state = state.copyWith(
      isFiltered: false,
      searchQuery: '',
      startDate: null,
      endDate: null,
      status: '',
      transactionType: '',
    );

    await fetch();
    state = state.copyWith(isRefresh: false);
  }

  void clearAllFilters() {
    ref.read(posTransDateProvider.notifier).setDatesToNull();
    ref.read(posFilterTransTypeProvider.notifier).state =
        PosFilterTransType.all;
    ref.read(posFilterTransStatusProvider.notifier).state =
        PosFilterTransStatus.all;

    state = state.copyWith(
      startDate: null,
      endDate: null,
      status: '',
      transactionType: '',
      searchQuery: '',
    );
  }

  bool get shouldShowLoading {
    return state.isLoading && state.filteredList.isNotEmpty && !state.isRefresh;
  }

  bool get shouldShowEndOfList {
    return !state.isLoading && !state.hasMore && state.filteredList.isNotEmpty;
  }

  // bool get shouldShowLoading {
  //   return state.isLoading && state.dataList.isNotEmpty && !state.isRefresh;
  // }
  // bool get shouldShowEndOfList {
  //   return !state.isLoading && !state.hasMore && state.dataList.isNotEmpty;
  // }
}
