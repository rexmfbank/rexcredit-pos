import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

class PosCardPurchaseState extends Equatable {
  final BaseAppTransactionResponse baseAppResponse;
  final String purchaseAmount;
  final String purchaseStatusCode;
  final String purchaseMessage;
  final bool isLoading;
  final bool isQuickPurchase;
  final bool buttonEnabled;
  final String rrnNumber;
  final String stanNumber;

  const PosCardPurchaseState({
    required this.baseAppResponse,
    required this.purchaseAmount,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
    required this.isLoading,
    required this.isQuickPurchase,
    required this.buttonEnabled,
    required this.rrnNumber,
    required this.stanNumber,
  });

  PosCardPurchaseState copyWith({
    BaseAppTransactionResponse? transactionResponse,
    String? purchaseAmount,
    String? purchaseStatusCode,
    String? purchaseMessage,
    bool? isLoading,
    bool? isQuickPurchase,
    bool? buttonEnabled,
    String? rrnNumber,
    String? stanNumber,
  }) {
    return PosCardPurchaseState(
      baseAppResponse: transactionResponse ?? this.baseAppResponse,
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      purchaseStatusCode: purchaseStatusCode ?? this.purchaseStatusCode,
      purchaseMessage: purchaseMessage ?? this.purchaseMessage,
      isLoading: isLoading ?? this.isLoading,
      isQuickPurchase: isQuickPurchase ?? this.isQuickPurchase,
      buttonEnabled: buttonEnabled ?? this.buttonEnabled,
      rrnNumber: rrnNumber ?? this.rrnNumber,
      stanNumber: stanNumber ?? this.stanNumber,
    );
  }

  @override
  List<Object?> get props => [
    baseAppResponse,
    purchaseAmount,
    purchaseStatusCode,
    purchaseMessage,
    isLoading,
    isQuickPurchase,
    buttonEnabled,
    rrnNumber,
    stanNumber,
  ];
}
