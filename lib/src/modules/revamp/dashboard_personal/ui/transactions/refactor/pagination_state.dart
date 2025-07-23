import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class PaginationState extends Equatable {
  const PaginationState({
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
    this.status = '',
    this.transactionType = '',
  });

  final List<TransferData> dataList;
  final List<TransferData> filteredList;
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
  final String status;
  final String transactionType;

  PaginationState copyWith({
    List<TransferData>? dataList,
    List<TransferData>? filteredList,
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
    String? status,
    String? transactionType,
  }) {
    return PaginationState(
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
      status: status ?? this.status,
      transactionType: transactionType ?? this.transactionType,
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
    status,
    transactionType,
  ];
}
