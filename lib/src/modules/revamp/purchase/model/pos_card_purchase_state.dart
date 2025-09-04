import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

class PosCardPurchaseState extends Equatable {
  final BaseAppTransactionResponse transactionResponse;
  final String purchaseAmount;
  final String purchaseStatusCode;
  final String purchaseMessage;
  final bool isLoading;
  final bool isQuickPurchase;
  final String rrnNumber;

  const PosCardPurchaseState({
    required this.transactionResponse,
    required this.purchaseAmount,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
    required this.isLoading,
    required this.isQuickPurchase,
    required this.rrnNumber,
  });

  PosCardPurchaseState copyWith({
    BaseAppTransactionResponse? transactionResponse,
    String? purchaseAmount,
    String? purchaseStatusCode,
    String? purchaseMessage,
    bool? isLoading,
    bool? isQuickPurchase,
    String? rrnNumber,
  }) {
    return PosCardPurchaseState(
      transactionResponse: transactionResponse ?? this.transactionResponse,
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      purchaseStatusCode: purchaseStatusCode ?? this.purchaseStatusCode,
      purchaseMessage: purchaseMessage ?? this.purchaseMessage,
      isLoading: isLoading ?? this.isLoading,
      isQuickPurchase: isQuickPurchase ?? this.isQuickPurchase,
      rrnNumber: rrnNumber ?? this.rrnNumber,
    );
  }

  @override
  List<Object?> get props => [
    transactionResponse,
    purchaseAmount,
    purchaseStatusCode,
    purchaseMessage,
    isLoading,
    isQuickPurchase,
    rrnNumber,
  ];
}
