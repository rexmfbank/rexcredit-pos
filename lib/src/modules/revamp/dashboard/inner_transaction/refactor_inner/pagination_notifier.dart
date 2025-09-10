import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/inner_transaction/refactor_inner/trans_date_notifier.dart';
import 'package:rex_app/src/modules/revamp/dashboard/inner_transaction/refactor_inner/trans_provider.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'pagination_state.dart';

final paginationProvider =
    StateNotifierProvider<PaginationNotifier, PaginationState>(
      (ref) => PaginationNotifier(ref),
    );

class PaginationNotifier extends StateNotifier<PaginationState> {
  PaginationNotifier(this.ref) : super(const PaginationState());
  final Ref ref;

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

    try {
      final authToken = ref.read(appAuthTokenProvider);
      final nuban = ref.read(userNubanProvider);

      final apiResponse = await RexApi.instance.fetchMiniStatement(
        authToken: authToken ?? '',
        request: MiniStatementRequest(
          accountNo: nuban,
          entityCode: 'RMB',
          pageIndex: state.pageIndex,
          pageSize: state.pageSize,
          tranCode: '',
          startDate: '',
          endDate: '',
          status: '',
          transactionType: '',
          tranDesc: '', // Empty for normal fetch
        ),
      );

      if (apiResponse.responseCode == '000') {
        final newItems = apiResponse.data ?? <TransferData>[];
        List<TransferData> updatedDataList;

        if (state.isRefresh || state.pageIndex == 1) {
          updatedDataList = newItems;
        } else {
          updatedDataList = [...state.dataList, ...newItems];
        }

        state = state.copyWith(
          pageIndex: state.pageIndex + 1,
          isLoading: false,
          hasMore:
              newItems.length >= state.pageSize &&
              apiResponse.hasNextPage == true &&
              state.pageIndex <= apiResponse.totalPages,
          dataList: updatedDataList,
          filteredList: updatedDataList,
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

    try {
      final authToken = ref.read(appAuthTokenProvider);
      final nuban = ref.read(userNubanProvider);

      final res = await RexApi.instance.fetchMiniStatement(
        authToken: authToken ?? '',
        request: MiniStatementRequest(
          accountNo: nuban,
          entityCode: 'RMB',
          pageIndex: state.pageIndex,
          pageSize: state.pageSize,
          tranCode: '',
          startDate: state.startDate ?? '',
          endDate: state.endDate ?? '',
          status: state.status,
          transactionType: state.transactionType,
          tranDesc: state.searchQuery,
        ),
      );

      if (res.responseCode == '000') {
        final newItems = res.data ?? <TransferData>[];
        List<TransferData> updatedDataList;

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

  // Updated search method to work with API
  Future<void> applySearch(String query) async {
    // Update the search query in state
    state = state.copyWith(
      searchQuery: query,
      pageIndex: 1,
      dataList: [],
      filteredList: [],
      hasMore: true,
    );

    // Fetch data with search query
    await _fetchWithFiltersAndSearch();
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isRefresh: true,
      isLoading: false,
      hasMore: true,
      pageIndex: 1,
    );

    // Clear all filters when refreshing
    ref.read(transactionDateProvider.notifier).setDatesToNull();
    ref.read(selectedTransactionTypeProvider.notifier).state =
        FilterTransactionType.all;
    ref.read(selectedTransactionStatusProvider.notifier).state =
        FilterTransactionStatus.all;

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
    ref.read(transactionDateProvider.notifier).setDatesToNull();
    ref.read(selectedTransactionTypeProvider.notifier).state =
        FilterTransactionType.all;
    ref.read(selectedTransactionStatusProvider.notifier).state =
        FilterTransactionStatus.all;

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
}
