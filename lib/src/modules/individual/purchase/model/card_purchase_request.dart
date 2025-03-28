import 'package:equatable/equatable.dart';

class CardPurchaseRequest extends Equatable {
  final String transactionType;
  final String amount;
  final String print;

  const CardPurchaseRequest({
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
