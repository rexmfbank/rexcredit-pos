import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class EodPaginationState extends Equatable {
  final List<PosTransactionsResponseData> dataList;
  final int pageIndex;
  final int pageSize;
  final bool hasMore;
  final bool isLoading;
  final bool isInitialized;
  final bool isFiltered;
  final bool isRefresh;

  const EodPaginationState({
    this.dataList = const [],
    this.pageIndex = 1,
    this.pageSize = 20,
    this.hasMore = true,
    this.isLoading = false,
    this.isInitialized = false,
    this.isFiltered = false,
    this.isRefresh = false,
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
  ];
}
