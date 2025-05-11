import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class AllFilterState extends Equatable {
  final List<TransferData> dataList;
  final List<TransferData> filterList;
  final int pageSize;
  final int pageIndex;
  final bool hasMore;
  final bool isLoading;

  const AllFilterState({
    required this.dataList,
    required this.filterList,
    required this.pageSize,
    required this.pageIndex,
    required this.hasMore,
    required this.isLoading,
  });

  AllFilterState copyWith({
    List<TransferData>? dataList,
    List<TransferData>? filterList,
    int? pageSize,
    int? pageIndex,
    bool? hasMore,
    bool? isLoading,
  }) {
    return AllFilterState(
      dataList: dataList ?? this.dataList,
      filterList: filterList ?? this.filterList,
      pageSize: pageSize ?? this.pageSize,
      pageIndex: pageIndex ?? this.pageIndex,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        dataList,
        filterList,
        pageSize,
        pageIndex,
        hasMore,
        isLoading,
      ];
}
