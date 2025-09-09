import 'package:equatable/equatable.dart';

class BaseAppCardPurchaseRequest extends Equatable {
  final String transactionType;
  final String amount;
  final String print;
  final String rrn;
  final String stan;

  const BaseAppCardPurchaseRequest({
    required this.transactionType,
    required this.amount,
    required this.print,
    required this.rrn,
    required this.stan,
  });

  Map<String, dynamic> toJson() => {
    "transType": transactionType,
    "amount": amount,
    "print": print,
    "rrn": rrn,
    "stan": stan,
  };

  @override
  List<Object?> get props => [transactionType, amount, print, rrn, stan];
}
