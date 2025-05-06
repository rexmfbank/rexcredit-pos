import 'package:equatable/equatable.dart';

class AccountTopUpRequest extends Equatable {
  final String cardId;
  final String amount;

  const AccountTopUpRequest({
    required this.cardId,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
        "cardId": cardId,
        "amount": amount,
      };

  @override
  String toString() => {
        "CLASS": "AccountTopUpRequest",
        "cardId": cardId,
        "amount": amount,
      }.toString();

  @override
  List<Object?> get props => [cardId, amount];
}
