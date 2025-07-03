import 'package:equatable/equatable.dart';

class PosTransactionsRequest extends Equatable {
  final String orderType;

  const PosTransactionsRequest({required this.orderType});

  factory PosTransactionsRequest.fromJson(Map<String, dynamic> json) {
    return PosTransactionsRequest(orderType: json['orderType']);
  }

  Map<String, dynamic> toJson() => {"orderType": orderType};

  @override
  List<Object?> get props => [orderType];
}
