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
  final bool isFromNotif;
  final String posNotifAmount;
  final String posNotifTerminalSerialNo;
  final String posNotifRrn;
  final String posNotifStan;
  final String posNotifInvoiceId;

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
    required this.isFromNotif,
    required this.stanNumber,
    required this.posNotifAmount,
    required this.posNotifTerminalSerialNo,
    required this.posNotifRrn,
    required this.posNotifStan,
    required this.posNotifInvoiceId,
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
    bool? isFromNotif,
    String? stanNumber,
    String? posNotifAmount,
    String? posNotifTerminalSerialNo,
    String? posNotifRrn,
    String? posNotifStan,
    String? posNotifInvoiceId,
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
      isFromNotif: isFromNotif ?? this.isFromNotif,
      rrnNumber: rrnNumber ?? this.rrnNumber,
      stanNumber: stanNumber ?? this.stanNumber,
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
    isFromNotif,
    stanNumber,
    posNotifAmount,
    posNotifTerminalSerialNo,
    posNotifRrn,
    posNotifStan,
    posNotifInvoiceId,
  ];
}
