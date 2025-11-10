import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

class PosCardPurchaseState extends Equatable {
  final BaseAppTransResponse baseAppResponse;
  final TsqTransactionData tsqTransData;
  final String purchaseAmount;
  final String purchaseStatusCode;
  final String purchaseMessage;
  final bool isLoading;
  final bool isQuickPurchase;
  final bool isTsqTransDataNull;
  final bool isButtonEnabled;
  final bool isPrintingDone;
  final bool isTsqChecking;
  final bool needsTsqCheck;
  final String rrnNumber;
  final String stanNumber;

  const PosCardPurchaseState({
    required this.baseAppResponse,
    required this.tsqTransData,
    required this.purchaseAmount,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
    required this.isLoading,
    required this.isQuickPurchase,
    required this.isButtonEnabled,
    required this.isTsqTransDataNull,
    required this.isPrintingDone,
    required this.isTsqChecking,
    required this.needsTsqCheck,
    required this.rrnNumber,
    required this.stanNumber,
  });

  PosCardPurchaseState copyWith({
    BaseAppTransResponse? baseAppResponse,
    TsqTransactionData? tsqTransData,
    String? purchaseAmount,
    String? purchaseStatusCode,
    String? purchaseMessage,
    bool? isLoading,
    bool? isQuickPurchase,
    bool? isButtonEnabled,
    bool? isTsqTransDataNull,
    bool? isPrintingDone,
    bool? isTsqChecking,
    bool? needsTsqCheck,
    String? rrnNumber,
    String? stanNumber,
  }) {
    return PosCardPurchaseState(
      baseAppResponse: baseAppResponse ?? this.baseAppResponse,
      tsqTransData: tsqTransData ?? this.tsqTransData,
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      purchaseStatusCode: purchaseStatusCode ?? this.purchaseStatusCode,
      purchaseMessage: purchaseMessage ?? this.purchaseMessage,
      isLoading: isLoading ?? this.isLoading,
      isQuickPurchase: isQuickPurchase ?? this.isQuickPurchase,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isTsqTransDataNull: isTsqTransDataNull ?? this.isTsqTransDataNull,
      isPrintingDone: isPrintingDone ?? this.isPrintingDone,
      isTsqChecking: isTsqChecking ?? this.isTsqChecking,
      needsTsqCheck: needsTsqCheck ?? this.needsTsqCheck,
      rrnNumber: rrnNumber ?? this.rrnNumber,
      stanNumber: stanNumber ?? this.stanNumber,
    );
  }

  @override
  List<Object?> get props => [
    baseAppResponse,
    tsqTransData,
    purchaseAmount,
    purchaseStatusCode,
    purchaseMessage,
    isLoading,
    isQuickPurchase,
    isButtonEnabled,
    isTsqTransDataNull,
    isPrintingDone,
    isTsqChecking,
    needsTsqCheck,
    rrnNumber,
    stanNumber,
  ];
}
