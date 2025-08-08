import 'package:equatable/equatable.dart';

class PosTransactionsRequest extends Equatable {
  final String orderType;
  final int pageSize;
  final int pageIndex;
  final String? startDate;
  final String? endDate;
  final String? transactionType;
  final String? tranDesc;
  final String? status;

  const PosTransactionsRequest({
    required this.orderType,
    required this.pageSize,
    required this.pageIndex,
    this.startDate,
    this.endDate,
    this.transactionType,
    this.tranDesc,
    this.status,
  });

  Map<String, dynamic> toJson() {
    if (startDate == null && endDate == null) {
      return {
        "orderType": orderType,
        "pageSize": pageSize,
        "pageIndex": pageIndex,
      };
    } else {
      return {
        "orderType": orderType,
        "pageSize": pageSize,
        "pageIndex": pageIndex,
        "startDate": startDate,
        "endDate": endDate,
        "transactionType": transactionType,
        "status": status,
        "tranDesc": tranDesc,
      };
    }
  }

  @override
  List<Object?> get props => [
    orderType,
    pageSize,
    pageIndex,
    startDate,
    endDate,
    transactionType,
    status,
    tranDesc,
  ];
}
