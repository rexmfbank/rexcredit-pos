import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

class PosCardPurchaseState extends Equatable {
  final BaseAppTransactionResponse transactionResponse;
  final String purchaseAmount;
  final String purchaseStatusCode;
  final String purchaseMessage;
  final bool loadingApi;
  final bool isQuickPurchase;

  const PosCardPurchaseState({
    required this.transactionResponse,
    required this.purchaseAmount,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
    required this.loadingApi,
    required this.isQuickPurchase,
  });

  PosCardPurchaseState copyWith({
    BaseAppTransactionResponse? transactionResponse,
    String? purchaseAmount,
    String? purchaseStatusCode,
    String? purchaseMessage,
    bool? loadingApi,
    bool? isQuickPurchase,
  }) {
    return PosCardPurchaseState(
      transactionResponse: transactionResponse ?? this.transactionResponse,
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      purchaseStatusCode: purchaseStatusCode ?? this.purchaseStatusCode,
      purchaseMessage: purchaseMessage ?? this.purchaseMessage,
      loadingApi: loadingApi ?? this.loadingApi,
      isQuickPurchase: isQuickPurchase ?? this.isQuickPurchase,
    );
  }

  @override
  List<Object?> get props => [
        transactionResponse,
        purchaseAmount,
        purchaseStatusCode,
        purchaseMessage,
        loadingApi,
        isQuickPurchase,
      ];
}
