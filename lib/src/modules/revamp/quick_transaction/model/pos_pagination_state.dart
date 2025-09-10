import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';

class PosPaginationState extends Equatable {
  final List<PosTransactionsResponseData> dataList;
  final List<PosTransactionsResponseData> filteredList;
  final int pageIndex;
  final int pageSize;
  final bool hasMore;
  final bool isLoading;
  final bool isInitialized;
  final bool isFiltered;
  final String searchQuery;
  final String? startDate;
  final String? endDate;
  final bool isRefresh;
  final String transactionStatus;
  final String transactionType;
  final String transactionCode;

  const PosPaginationState({
    this.dataList = const [],
    this.filteredList = const [],
    this.pageIndex = 1,
    this.pageSize = 20,
    this.hasMore = true,
    this.isLoading = false,
    this.isInitialized = false,
    this.isFiltered = false,
    this.searchQuery = '',
    this.startDate,
    this.endDate,
    this.isRefresh = false,
    this.transactionStatus = '',
    this.transactionType = '',
    this.transactionCode = '',
  });

  PosPaginationState copyWith({
    List<PosTransactionsResponseData>? dataList,
    List<PosTransactionsResponseData>? filteredList,
    int? pageIndex,
    int? pageSize,
    bool? hasMore,
    bool? isLoading,
    bool? isInitialized,
    bool? isFiltered,
    String? searchQuery,
    String? startDate,
    String? endDate,
    bool? isRefresh,
    String? transactionStatus,
    String? transactionType,
    String? transactionCode,
  }) {
    return PosPaginationState(
      dataList: dataList ?? this.dataList,
      filteredList: filteredList ?? this.filteredList,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
      isFiltered: isFiltered ?? this.isFiltered,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isRefresh: isRefresh ?? this.isRefresh,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      transactionType: transactionType ?? this.transactionType,
      transactionCode: transactionCode ?? this.transactionCode,
    );
  }

  @override
  List<Object?> get props => [
    dataList,
    filteredList,
    pageIndex,
    pageSize,
    hasMore,
    isLoading,
    isInitialized,
    isFiltered,
    searchQuery,
    startDate,
    endDate,
    isRefresh,
    transactionStatus,
    transactionType,
    transactionCode,
  ];
}
