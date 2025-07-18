import 'package:equatable/equatable.dart';

class PosTransactionsRequest extends Equatable {
  final String orderType;
  final int pageSize;
  final int pageIndex;
  final String? startDate;
  final String? endDate;

  const PosTransactionsRequest({
    required this.orderType,
    required this.pageSize,
    required this.pageIndex,
    this.startDate,
    this.endDate,
  });

  // factory PosTransactionsRequest.fromJson(Map<String, dynamic> json) {

  //   return PosTransactionsRequest(orderType: json['orderType'], pageSize: );
  // }

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
      };
    }
  }

  @override
  List<Object?> get props => [orderType];
}
