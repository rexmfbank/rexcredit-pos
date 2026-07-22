import 'package:equatable/equatable.dart';

class PosCardPurchaseState extends Equatable {
  final String purchaseAmount;
  final String purchaseStatusCode;
  final String purchaseMessage;
  final bool isPrintingDone;
  final bool needsTsqCheck;
  final bool isLoading;
  final bool isQuickPurchase;
  final bool isTsqTransDataNull;
  final bool isButtonEnabled;
  final bool isInputEnabled;
  final bool isTsqChecking;
  final bool hasReturn;
  final int batteryLevel;
  final String rrnAmount;
  final String rrnNumber;
  final String stanNumber;
  final String posAcctNo;
  final String posSerialNo;
  final String posAuthToken;
  final String posTerminalId;
  final String posMerchantId;
  final String posMerchantName;
  final String posAppVersionLocal;
  final String tsqCheckCode;
  final String tsqCheckMessage;
  final String baseappAmount;
  final String baseappPan;
  final String baseappRRN;
  final String baseappStan;
  final String baseappBankName;
  final String baseappTransType;
  final String baseappDateTime;
  final String baseappAID;
  final String baseappMerchantId;
  final String baseappMerchantName;
  final String baseappLabel;
  final String baseappStatusCode;
  final String baseappCurrency;
  final String baseappMaskedPan;
  final String baseappMessage;
  final String baseappVersion;
  final String baseappCardExpiryDate;
  final String baseappCardHolderName;
  final String baseappAuthCode;
  final String baseappName;
  final String posNotifAmount;
  final String posNotifTerminalSerialNo;
  final String posNotifRrn;
  final String posNotifStan;
  final String posNotifInvoiceId;
  final bool isFromNotif;
  final String? cardBalanceResponse;
  final bool cardBalanceReturns;
  final String cardBalanceAmount;

  const PosCardPurchaseState({
    required this.purchaseAmount,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
    required this.isLoading,
    required this.isButtonEnabled,
    required this.isTsqTransDataNull,
    required this.isPrintingDone,
    required this.isTsqChecking,
    required this.isQuickPurchase,
    required this.needsTsqCheck,
    required this.hasReturn,
    required this.batteryLevel,
    required this.rrnNumber,
    required this.isFromNotif,
    required this.stanNumber,
    required this.posNotifAmount,
    required this.posNotifTerminalSerialNo,
    required this.posNotifRrn,
    required this.posNotifStan,
    required this.posNotifInvoiceId,
    required this.posAcctNo,
    required this.posSerialNo,
    required this.posAuthToken,
    required this.posTerminalId,
    required this.posMerchantId,
    required this.posMerchantName,
    required this.posAppVersionLocal,
    required this.rrnAmount,
    required this.tsqCheckCode,
    required this.tsqCheckMessage,
    required this.baseappAmount,
    required this.baseappPan,
    required this.baseappRRN,
    required this.baseappStan,
    required this.baseappBankName,
    required this.baseappTransType,
    required this.baseappDateTime,
    required this.baseappAID,
    required this.baseappMerchantId,
    required this.baseappMerchantName,
    required this.baseappLabel,
    required this.baseappStatusCode,
    required this.baseappCurrency,
    required this.baseappMaskedPan,
    required this.baseappMessage,
    required this.baseappVersion,
    required this.baseappCardExpiryDate,
    required this.baseappCardHolderName,
    required this.baseappAuthCode,
    required this.baseappName,
    required this.isInputEnabled,
    this.cardBalanceResponse,
    required this.cardBalanceReturns,
    required this.cardBalanceAmount,
  });

  PosCardPurchaseState copyWith({
    String? purchaseAmount,
    String? purchaseStatusCode,
    String? purchaseMessage,
    bool? isLoading,
    bool? isButtonEnabled,
    bool? isQuickPurchase,
    bool? isTsqTransDataNull,
    bool? isPrintingDone,
    bool? isTsqChecking,
    bool? needsTsqCheck,
    bool? hasReturn,
    int? batteryLevel,
    String? rrnNumber,
    bool? isFromNotif,
    String? stanNumber,
    String? posNotifAmount,
    String? posNotifTerminalSerialNo,
    String? posNotifRrn,
    String? posNotifStan,
    String? posNotifInvoiceId,
    String? posAcctNo,
    String? posSerialNo,
    String? posAuthToken,
    String? posTerminalId,
    String? posMerchantId,
    String? posMerchantName,
    String? posAppVersionLocal,
    String? rrnAmount,
    String? acctNo,
    String? serialNo,
    String? tsqCheckCode,
    String? tsqCheckMessage,
    String? baseappAmount,
    String? baseappPan,
    String? baseappRRN,
    String? baseappStan,
    String? baseappBankName,
    String? baseappTransType,
    String? baseappDateTime,
    String? baseappAID,
    String? baseappMerchantId,
    String? baseappMerchantName,
    String? baseappLabel,
    String? baseappStatusCode,
    String? baseappCurrency,
    String? baseappMaskedPan,
    String? baseappMessage,
    String? baseappVersion,
    String? baseappCardExpiryDate,
    String? baseappCardHolderName,
    String? baseappAuthCode,
    String? baseappName,
    bool? isInputEnabled,
    String? cardBalanceResponse,
    bool? cardBalanceReturns,
    String? cardBalanceAmount,
  }) {
    return PosCardPurchaseState(
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      purchaseStatusCode: purchaseStatusCode ?? this.purchaseStatusCode,
      purchaseMessage: purchaseMessage ?? this.purchaseMessage,
      isLoading: isLoading ?? this.isLoading,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isTsqTransDataNull: isTsqTransDataNull ?? this.isTsqTransDataNull,
      isPrintingDone: isPrintingDone ?? this.isPrintingDone,
      isTsqChecking: isTsqChecking ?? this.isTsqChecking,
      isQuickPurchase: isQuickPurchase ?? this.isQuickPurchase,
      needsTsqCheck: needsTsqCheck ?? this.needsTsqCheck,
      hasReturn: hasReturn ?? this.hasReturn,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isFromNotif: isFromNotif ?? this.isFromNotif,
      rrnNumber: rrnNumber ?? this.rrnNumber,
      stanNumber: stanNumber ?? this.stanNumber,
      posNotifAmount: posNotifAmount ?? this.posNotifAmount,
      posNotifTerminalSerialNo:
          posNotifTerminalSerialNo ?? this.posNotifTerminalSerialNo,
      posNotifRrn: posNotifRrn ?? this.posNotifRrn,
      posNotifStan: posNotifStan ?? this.posNotifStan,
      posNotifInvoiceId: posNotifInvoiceId ?? this.posNotifInvoiceId,
      posAcctNo: posAcctNo ?? this.posAcctNo,
      posSerialNo: posSerialNo ?? this.posSerialNo,
      posAuthToken: posAuthToken ?? this.posAuthToken,
      posTerminalId: posTerminalId ?? this.posTerminalId,
      posMerchantId: posMerchantId ?? this.posMerchantId,
      posMerchantName: posMerchantName ?? this.posMerchantName,
      posAppVersionLocal: posAppVersionLocal ?? this.posAppVersionLocal,
      rrnAmount: rrnAmount ?? this.rrnAmount,
      tsqCheckCode: tsqCheckCode ?? this.tsqCheckCode,
      tsqCheckMessage: tsqCheckMessage ?? this.tsqCheckMessage,
      baseappAmount: baseappAmount ?? this.baseappAmount,
      baseappPan: baseappPan ?? this.baseappPan,
      baseappRRN: baseappRRN ?? this.baseappRRN,
      baseappStan: baseappStan ?? this.baseappStan,
      baseappBankName: baseappBankName ?? this.baseappBankName,
      baseappTransType: baseappTransType ?? this.baseappTransType,
      baseappDateTime: baseappDateTime ?? this.baseappDateTime,
      baseappAID: baseappAID ?? this.baseappAID,
      baseappMerchantId: baseappMerchantId ?? this.baseappMerchantId,
      baseappMerchantName: baseappMerchantName ?? this.baseappMerchantName,
      baseappLabel: baseappLabel ?? this.baseappLabel,
      baseappStatusCode: baseappStatusCode ?? this.baseappStatusCode,
      baseappCurrency: baseappCurrency ?? this.baseappCurrency,
      baseappMaskedPan: baseappMaskedPan ?? this.baseappMaskedPan,
      baseappMessage: baseappMessage ?? this.baseappMessage,
      baseappVersion: baseappVersion ?? this.baseappVersion,
      baseappCardExpiryDate:
          baseappCardExpiryDate ?? this.baseappCardExpiryDate,
      baseappCardHolderName:
          baseappCardHolderName ?? this.baseappCardHolderName,
      baseappAuthCode: baseappAuthCode ?? this.baseappAuthCode,
      baseappName: baseappName ?? this.baseappName,
      isInputEnabled: isInputEnabled ?? this.isInputEnabled,
      cardBalanceResponse: cardBalanceResponse ?? this.cardBalanceResponse,
      cardBalanceReturns: cardBalanceReturns ?? this.cardBalanceReturns,
      cardBalanceAmount: cardBalanceAmount ?? this.cardBalanceAmount,
    );
  }

  @override
  List<Object?> get props => [
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
    hasReturn,
    batteryLevel,
    rrnNumber,
    isFromNotif,
    stanNumber,
    posNotifAmount,
    posNotifTerminalSerialNo,
    posNotifRrn,
    posNotifStan,
    posNotifInvoiceId,
    rrnAmount,
    posAcctNo,
    posSerialNo,
    posAuthToken,
    posTerminalId,
    posMerchantId,
    posMerchantName,
    posAppVersionLocal,
    tsqCheckCode,
    tsqCheckMessage,
    baseappAmount,
    baseappPan,
    baseappRRN,
    baseappStan,
    baseappBankName,
    baseappTransType,
    baseappDateTime,
    baseappAID,
    baseappMerchantId,
    baseappMerchantName,
    baseappLabel,
    baseappStatusCode,
    baseappCurrency,
    baseappMaskedPan,
    baseappMessage,
    baseappVersion,
    baseappCardExpiryDate,
    baseappCardHolderName,
    baseappAuthCode,
    baseappName,
    isInputEnabled,
    cardBalanceResponse,
    cardBalanceReturns,
    cardBalanceAmount,
  ];
}
