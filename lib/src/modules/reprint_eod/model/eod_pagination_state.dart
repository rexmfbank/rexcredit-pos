import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

class EodPaginationState extends Equatable {
  final List<PosTransactionsResponseData> dataList;
  final int pageIndex;
  final int pageSize;
  final bool hasMore;
  final bool isLoading;
  final bool isInitialized;
  final bool isFiltered;
  final bool isRefresh;
  final bool overlayLoading;
  final String searchQuery;
  final int totalContent;

  const EodPaginationState({
    this.dataList = const [],
    this.pageIndex = 1,
    this.pageSize = 10,
    this.hasMore = true,
    this.isLoading = false,
    this.isInitialized = false,
    this.isFiltered = false,
    this.isRefresh = false,
    this.overlayLoading = false,
    this.searchQuery = '',
    this.totalContent = 0,
  });

  EodPaginationState copyWith({
    List<PosTransactionsResponseData>? dataList,
    int? pageIndex,
    int? pageSize,
    bool? hasMore,
    bool? isLoading,
    bool? isInitialized,
    bool? isFiltered,
    bool? isRefresh,
    bool? overlayLoading,
    String? searchQuery,
    int? totalContent,
  }) {
    return EodPaginationState(
      dataList: dataList ?? this.dataList,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
      isFiltered: isFiltered ?? this.isFiltered,
      isRefresh: isRefresh ?? this.isRefresh,
      overlayLoading: overlayLoading ?? this.overlayLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      totalContent: totalContent ?? this.totalContent,
    );
  }

  @override
  List<Object?> get props => [
    dataList,
    pageIndex,
    pageSize,
    hasMore,
    isLoading,
    isInitialized,
    isFiltered,
    isRefresh,
    overlayLoading,
    searchQuery,
    totalContent,
  ];
}
