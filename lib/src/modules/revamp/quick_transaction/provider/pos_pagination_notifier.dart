import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_pagination_state.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
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
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    //
    final authToken = ref.watch(posAuthTokenProvider);
    final appVersion = ref.watch(appVersionProvider);
    try {
      final apiResponse = await RexApi.instance.posTransactions(
        authToken: authToken ?? '',
        appVersion: appVersion,
        request: PosTransactionsRequest(
          orderType: "descending",
          pageSize: state.pageSize,
          pageIndex: state.pageIndex,
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

    // Reset filter states
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
}
