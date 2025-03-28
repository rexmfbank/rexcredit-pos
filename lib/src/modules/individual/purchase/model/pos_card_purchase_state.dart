import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/individual/purchase/model/intent_transaction_response.dart';

class PosCardPurchaseState extends Equatable {
  final IntentTransactionResponse transactionResponse;
  final String purchaseAmount;
  final String purchaseStatusCode;
  final String purchaseMessage;

  const PosCardPurchaseState({
    required this.transactionResponse,
    required this.purchaseAmount,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
  });

  PosCardPurchaseState copyWith({
    IntentTransactionResponse? transactionResponse,
    String? purchaseAmount,
    String? purchaseStatusCode,
    String? purchaseMessage,
  }) {
    return PosCardPurchaseState(
      transactionResponse: transactionResponse ?? this.transactionResponse,
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      purchaseStatusCode: purchaseStatusCode ?? this.purchaseStatusCode,
      purchaseMessage: purchaseMessage ?? this.purchaseMessage,
    );
  }

  @override
  List<Object?> get props => [
        transactionResponse,
        purchaseAmount,
        purchaseStatusCode,
        purchaseMessage
      ];
}
