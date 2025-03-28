import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/all_filter_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final allFilterProvider = NotifierProvider<AllFilterNotifier, AllFilterState>(
  () => AllFilterNotifier(),
);

class AllFilterNotifier extends Notifier<AllFilterState> {
  @override
  AllFilterState build() {
    return const AllFilterState(
      dataList: [],
      filterList: [],
      pageSize: 10,
      pageIndex: 1,
      hasMore: true,
      isLoading: false,
    );
  }

  Future<void> fetch() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    //
    final authToken = ref.watch(userAuthTokenProvider);
    final nuban = ref.watch(userNubanProvider);
    final entityCode = ref.watch(userEntityCodeProvider);
    //
    try {
      final res = await RexApi.instance.fetchMiniStatement(
        authToken: authToken ?? '',
        request: MiniStatementRequest(
          accountNo: nuban,
          entityCode: entityCode,
          pageIndex: state.pageIndex,
          pageSize: state.pageSize,
          tranCode: '',
          startDate: '',
          endDate: '',
        ),
      );
      if (res.responseCode == '000') {
        final newItems = res.data ?? [];
        state = state.copyWith(
          pageIndex: state.pageIndex + 1,
          isLoading: false,
        );
        if (newItems.length < state.pageSize) {
          state = state.copyWith(hasMore: false);
        }
        state = state.copyWith(dataList: [...newItems]);
        state = state.copyWith(filterList: [...state.dataList]);
      } else {
        state = state.copyWith(dataList: [], filterList: []);
      }
    } catch (error) {}
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: false,
      hasMore: true,
      pageIndex: 1,
      dataList: [],
      filterList: [],
    );
    fetch();
  }
}

final filterTransactionType = StateProvider<FilterTransactionType>((ref) {
  final selection = ref.watch(selectedFilter);
  switch (selection) {
    case 0:
      return FilterTransactionType.credit;
    case 1:
      return FilterTransactionType.debit;
    case 2:
      return FilterTransactionType.pending;
    case 3:
      return FilterTransactionType.success;
    case 4:
      return FilterTransactionType.failed;
    default:
      return FilterTransactionType.none;
  }
});

final selectedFilter = StateProvider<int>((ref) => 0);

enum FilterTransactionType {
  credit(name: 'Credit', code: 0),
  debit(name: 'Debit', code: 1),
  pending(name: 'Pending', code: 2),
  success(name: 'Success', code: 3),
  failed(name: 'Failed', code: 4),
  none(name: 'None', code: 5);

  const FilterTransactionType({
    required this.name,
    required this.code,
  });

  final String name;
  final int code;
}
