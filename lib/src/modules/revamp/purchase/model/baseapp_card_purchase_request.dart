import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/horizon_data.dart';

class BaseAppCardPurchaseRequest extends Equatable {
  final String transactionType;
  final String amount;
  final String print;
  final String rrn;
  final String stan;

  BaseAppCardPurchaseRequest({
    required this.transactionType,
    required this.amount,
    required this.print,
    required this.rrn,
  }) : stan = generate6DigitNumber();

  Map<String, dynamic> toJson() => {
    "transType": transactionType,
    "amount": amount,
    "print": print,
    "rrn": rrn,
    "stan": stan,
  };

  @override
  List<Object?> get props => [transactionType, amount, print, rrn];
}
