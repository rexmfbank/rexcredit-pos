import 'package:equatable/equatable.dart';

class BaseAppCardPurchaseRequest extends Equatable {
  final String transactionType;
  final String amount;
  final String print;

  const BaseAppCardPurchaseRequest({
    required this.transactionType,
    required this.amount,
    required this.print,
  });

  Map<String, dynamic> toJson() => {
        "transType": transactionType,
        "amount": amount,
        "print": print,
      };

  @override
  List<Object?> get props => [transactionType, amount, print];
}
