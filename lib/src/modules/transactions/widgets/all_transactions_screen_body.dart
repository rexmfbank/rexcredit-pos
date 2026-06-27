import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/login/widgets/dashboard_transaction_slide.dart';
import 'package:rex_app/src/modules/login/widgets/recent_transaction_item.dart';
import 'package:rex_app/src/modules/utils/routes/routes_imports.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AllTransactionsScreenBody extends ConsumerStatefulWidget {
  const AllTransactionsScreenBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllTransactionsScreenBodyState();
}

class _AllTransactionsScreenBodyState
    extends ConsumerState<AllTransactionsScreenBody> {
  //
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(paginationProvider.notifier).clearAllFilters();
    //   // Check if data already exists
    //   final currentState = ref.read(paginationProvider);
    //   if (currentState.dataList.isNotEmpty) {
    //     ref.read(paginationProvider.notifier).refresh();
    //   } else {
    //     // No data or error state, fetch fresh data
    //     ref.read(paginationProvider.notifier).fetch();
    //   }
    // });

    // _scrollController.addListener(() {
    //   if (_scrollController.position.maxScrollExtent ==
    //       _scrollController.offset) {
    //     ref.read(paginationProvider.notifier).fetch();
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentTransact = ref.watch(userRecentTransactionProvider);
    return Column(
      children: [
        // TransactionSearchFilter(
        //   onChangedText: (query) async {
        //     await ref.read(paginationProvider.notifier).applySearch(query);
        //   },
        //   onTap: () {
        //     showFilterTransaction(
        //       context: context,
        //       onClickApply: () {
        //         _applyFilters();
        //         context.pop();
        //       },
        //       onResetDateFilter: () {
        //         ref.read(paginationProvider.notifier).refresh();
        //         context.pop();
        //       },
        //     );
        //   },
        // ),
        SizedBox(height: 10),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            margin: EdgeInsets.all(16.ar),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.ar),
            ),
            child: recentTransact.when(
              data: (TData tData) {
                if (tData.transactions == null) {
                  return const TransText(text: Strings.recentTransactionError);
                }
                if (tData.transactions!.data.isEmpty) {
                  return const TransText(text: Strings.noTransactions);
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tData.transactions!.data.length,
                  itemBuilder: (context, index) {
                    return RecentTransactionItem(
                      transData: tData.transactions!.data[index],
                      canTap: true,
                    );
                  },
                );
              },
              error:
                  (error, stackTrace) =>
                      const TransText(text: Strings.recentTransactionError),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ],
    );
  }

  /*@override
  Widget build(BuildContext context) {
    final paginationState = ref.watch(paginationProvider);
    final paginationNotifier = ref.read(paginationProvider.notifier);
    //
    return Column(
      children: [
        TransactionSearchFilter(
          onChangedText: (query) async {
            await ref.read(paginationProvider.notifier).applySearch(query);
          },
          onTap: () {
            showFilterTransaction(
              context: context,
              onClickApply: () {
                _applyFilters();
                context.pop();
              },
              onResetDateFilter: () {
                ref.read(paginationProvider.notifier).refresh();
                context.pop();
              },
            );
          },
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            margin: EdgeInsets.all(16.ar),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.ar),
            ),
            child: _buildListContent(paginationState, paginationNotifier),
          ),
        ),
      ],
    );
  }*/

  /*void _applyFilters() {
    final paginationNotifier = ref.read(paginationProvider.notifier);
    final dateFilter = ref.read(transactionDateProvider);
    final transactionType = ref.read(selectedTransactionTypeProvider);
    final status = ref.read(selectedTransactionStatusProvider);

    // Prepare filter parameters
    final startDate =
        dateFilter.startDate != null
            ? DateFormat('yyyy-MM-dd').format(dateFilter.startDate!)
            : null;
    final endDate =
        dateFilter.endDate != null
            ? DateFormat('yyyy-MM-dd').format(dateFilter.endDate!)
            : null;

    // Apply backend filters
    paginationNotifier.applyFilters(
      startDate: startDate,
      endDate: endDate,
      status: status.code,
      transactionType: transactionType.code,
    );
  }*/

  /*Widget _buildListContent(
    PaginationState paginationState,
    PaginationNotifier paginationNotifier,
  ) {
    if (paginationState.filteredList.isEmpty && !paginationState.isLoading) {
      return const Center(child: Text('No transactions found'));
    }

    // Show initial loading state (when no data exists yet)
    if (paginationState.filteredList.isEmpty &&
        paginationState.isLoading &&
        !paginationState.isRefresh) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: paginationNotifier.refresh,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: paginationState.filteredList.length + 1,
        itemBuilder: (context, index) {
          if (index < paginationState.filteredList.length) {
            return RecentTransactionItem(
              transData: paginationState.filteredList[index],
              canTap: true,
            );
          } else {
            return _buildBottomIndicator(paginationState, paginationNotifier);
          }
        },
      ),
    );
  }*/

  /*Widget _buildBottomIndicator(
    PaginationState paginationState,
    PaginationNotifier paginationNotifier,
  ) {
    if (paginationState.filteredList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.ah),
      child: Center(
        child:
            paginationNotifier.shouldShowLoading
                ? const CircularLoader(height: 25, width: 25)
                : paginationNotifier.shouldShowEndOfList
                ? Text(Strings.endOfList, style: AppTextStyles.h2)
                : const SizedBox.shrink(),
      ),
    );
  }*/
}
