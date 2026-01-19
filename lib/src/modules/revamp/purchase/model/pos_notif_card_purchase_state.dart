import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

class PosNotifCardPurchaseState extends Equatable {
  final BaseAppTransResponse baseAppResponse;
  final TsqTransactionData tsqTransData;
  final String purchaseStatusCode;
  final String purchaseMessage;
  final bool isLoading;
  final bool isQuickPurchase;
  final bool isTsqTransDataNull;
  final bool isButtonEnabled;
  final bool isPrintingDone;
  final bool isTsqChecking;
  final bool needsTsqCheck;
  final String posNotifAmount;
  final String posNotifTerminalSerialNo;
  final String posNotifRrn;
  final String posNotifStan;
  final String posNotifInvoiceId;

  const PosNotifCardPurchaseState({
    required this.baseAppResponse,
    required this.tsqTransData,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
    required this.isLoading,
    required this.isQuickPurchase,
    required this.isButtonEnabled,
    required this.isTsqTransDataNull,
    required this.isPrintingDone,
    required this.isTsqChecking,
    required this.needsTsqCheck,
    required this.posNotifAmount,
    required this.posNotifTerminalSerialNo,
    required this.posNotifRrn,
    required this.posNotifStan,
    required this.posNotifInvoiceId,
  });

  PosNotifCardPurchaseState copyWith({
    BaseAppTransResponse? baseAppResponse,
    TsqTransactionData? tsqTransData,
    String? purchaseStatusCode,
    String? purchaseMessage,
    bool? isLoading,
    bool? isQuickPurchase,
    bool? isButtonEnabled,
    bool? isTsqTransDataNull,
    bool? isPrintingDone,
    bool? isTsqChecking,
    bool? needsTsqCheck,
    String? posNotifAmount,
    String? posNotifTerminalSerialNo,
    String? posNotifRrn,
    String? posNotifStan,
    String? posNotifInvoiceId,
  }) {
    return PosNotifCardPurchaseState(
      baseAppResponse: baseAppResponse ?? this.baseAppResponse,
      tsqTransData: tsqTransData ?? this.tsqTransData,
      purchaseStatusCode: purchaseStatusCode ?? this.purchaseStatusCode,
      purchaseMessage: purchaseMessage ?? this.purchaseMessage,
      isLoading: isLoading ?? this.isLoading,
      isQuickPurchase: isQuickPurchase ?? this.isQuickPurchase,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isTsqTransDataNull: isTsqTransDataNull ?? this.isTsqTransDataNull,
      isPrintingDone: isPrintingDone ?? this.isPrintingDone,
      isTsqChecking: isTsqChecking ?? this.isTsqChecking,
      needsTsqCheck: needsTsqCheck ?? this.needsTsqCheck,
      posNotifAmount: posNotifAmount ?? this.posNotifAmount,
      posNotifTerminalSerialNo:
          posNotifTerminalSerialNo ?? this.posNotifTerminalSerialNo,
      posNotifRrn: posNotifRrn ?? this.posNotifRrn,
      posNotifStan: posNotifStan ?? this.posNotifStan,
      posNotifInvoiceId: posNotifInvoiceId ?? this.posNotifInvoiceId,
    );
  }

  @override
  List<Object?> get props => [
    baseAppResponse,
    tsqTransData,
    purchaseStatusCode,
    purchaseMessage,
    isLoading,
    isQuickPurchase,
    isButtonEnabled,
    isTsqTransDataNull,
    isPrintingDone,
    isTsqChecking,
    needsTsqCheck,
    posNotifAmount,
    posNotifTerminalSerialNo,
    posNotifRrn,
    posNotifStan,
    posNotifInvoiceId,
  ];
}
