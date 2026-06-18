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
  final String? accountNo;
  final String? transCode;

  const PosTransactionsRequest({
    required this.orderType,
    required this.pageSize,
    required this.pageIndex,
    this.startDate,
    this.endDate,
    this.transactionType,
    this.tranDesc,
    this.status,
    this.accountNo,
    this.transCode,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderType": orderType,
      "pageSize": pageSize,
      "pageIndex": pageIndex,
      "startDate": startDate ?? '',
      "endDate": endDate ?? '',
      "transactionType": transactionType ?? '',
      "status": status ?? '',
      "tranDesc": tranDesc ?? '',
      "accountNo": accountNo ?? '',
      "tranCode": transCode ?? '',
    };
    /*if (startDate == null && endDate == null) {
      return {
        "orderType": orderType,
        "pageSize": pageSize,
        "pageIndex": pageIndex,
        "accountNo": accountNo,
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
        "accountNo": accountNo,
      };
    }*/
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
    accountNo,
    transCode,
  ];
}
