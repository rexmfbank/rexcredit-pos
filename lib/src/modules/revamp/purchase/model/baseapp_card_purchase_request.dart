import 'package:equatable/equatable.dart';

class BaseAppCardPurchaseRequest extends Equatable {
  final String transactionType;
  final String amount;
  final String print;
  final String rrn;

  const BaseAppCardPurchaseRequest({
    required this.transactionType,
    required this.amount,
    required this.print,
    required this.rrn,
  });

  // Map<String, dynamic> toJson() => {
  //   "transType": transactionType,
  //   "amount": amount,
  //   "print": print,
  //   "rrn": rrn,
  // };

  Map<String, dynamic> toJson() => {
    "transType": transactionType,
    "amount": amount,
    "print": print,
    "transactionReference": rrn,
  };

  @override
  List<Object?> get props => [transactionType, amount, print, rrn];
}
