import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/transaction_filter_date.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/all_filter.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/transaction_search_filter.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/show_filter_transaction.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/recent_transaction_item.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

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
  //
  List<TransferData> _dataList = [];
  List<TransferData> _filteredList = [];
  //
  final int _pageSize = 10;
  int _pageIndex = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  //
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetch();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _fetch();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> fetchWithDate() async {
    setState(() {
      _filteredList.clear();
    });
    final authToken = ref.watch(userAuthTokenProvider);
    final nuban = ref.watch(userNubanProvider);
    final entityCode = ref.watch(userEntityCodeProvider);
    final filterDate = ref.watch(transactionFilterDateProvider);
    //
    try {
      final res = await RexApi.instance.fetchMiniStatement(
        authToken: authToken ?? '',
        request: MiniStatementRequest(
          accountNo: nuban,
          entityCode: entityCode,
          pageIndex: 1,
          pageSize: 10,
          tranCode: '',
          startDate: filterDate.startDate?.dateYYYYMMDD() ?? '',
          endDate: filterDate.endDate?.dateYYYYMMDD() ?? '',
        ),
      );
      if (res.responseCode == '000') {
        List<TransferData> newItems = res.data ?? [];
        setState(() {
          _filteredList = newItems;
        });
      }
    } catch (error) {}
  }

  Future<void> _fetch() async {
    if (_isLoading) return;
    _isLoading = true;
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
          pageIndex: _pageIndex,
          pageSize: _pageSize,
          tranCode: '',
          startDate: '',
          endDate: '',
        ),
      );
      if (_pageIndex >= res.totalPages) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
        return;
      }

      if (res.responseCode == '000') {
        List<TransferData> newItems = res.data ?? [];
        setState(() {
          _pageIndex++;
          _isLoading = false;
          if (newItems.length < _pageSize || res.hasNextPage == false) {
            _hasMore = false;
          }
          _dataList.addAll(newItems);
          _filteredList = _dataList;
        });
      } else {
        setState(() {
          _dataList = [];
          _filteredList = [];
        });
      }
    } catch (error) {}
  }

  Future<void> refresh() async {
    setState(() {
      _isLoading = false;
      _hasMore = true;
      _pageIndex = 1;
      _dataList.clear();
      _filteredList.clear();
    });
    _fetch();
  }

  void _applyFilter() {
    final filter = ref.watch(filterTransactionType);
    setState(() {
      if (filter == FilterTransactionType.none) {
        _filteredList = _dataList;
      } else if (filter == FilterTransactionType.credit) {
        _filteredList = _dataList.where((data) => data.crDr == 'C').toList();
      } else if (filter == FilterTransactionType.debit) {
        _filteredList = _dataList.where((data) => data.crDr == 'D').toList();
      } else if (filter == FilterTransactionType.pending) {
        _filteredList = _dataList
            .where((data) => data.transactionStatus == 'PENDING')
            .toList();
      } else if (filter == FilterTransactionType.failed) {
        _filteredList = _dataList
            .where((data) => data.transactionStatus == 'FAILED')
            .toList();
      } else if (filter == FilterTransactionType.success) {
        _filteredList = _dataList
            .where((data) => data.transactionStatus == 'SUCCESSFUL')
            .toList();
      }
    });
  }

  void _applySearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredList = _dataList;
      } else {
        _filteredList = _dataList.where((transferData) {
          final narration = transferData.narration!.toLowerCase();
          final input = query.toLowerCase();
          return narration.contains(input);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterDate = ref.watch(transactionFilterDateProvider);
    return Column(
      children: [
        TransactionSearchFilter(
          onChangedText: _applySearch,
          onTap: () {
            showFilterTransaction(
              context: context,
              onClickApply: () async {
                if (filterDate.startDate != null &&
                    filterDate.endDate != null) {
                  fetchWithDate();
                } else {
                  _applyFilter();
                }
                context.pop();
              },
              onResetDateFilter: () {
                refresh();
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
            child: _filteredList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      itemCount: _filteredList.length + 1,
                      itemBuilder: (context, index) {
                        if (index < _filteredList.length) {
                          return RecentTransactionItem(
                            transData: _filteredList[index],
                            canTap: true,
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.ah),
                            child: Center(
                              child: _hasMore
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      StringAssets.endOfList,
                                      style: AppTextStyles.h2,
                                    ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
