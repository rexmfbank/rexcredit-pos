import 'package:equatable/equatable.dart';

class PosCardPurchaseState extends Equatable {
  final String purchaseAmount;
  final String purchaseStatusCode;
  final String purchaseMessage;
  final bool isPrintingDone;
  final bool needsTsqCheck;
  final bool isLoading;
  final bool isTsqTransDataNull;
  final bool isButtonEnabled;
  final bool isInputEnabled;
  final bool isTsqChecking;
  final String rrnAmount;
  final String rrnNumber;
  final String stanNumber;
  final String acctNo;
  final String serialNo;
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
  final bool isFromNotif;
  final String posNotifAmount;
  final String posNotifTerminalSerialNo;
  final String posNotifRrn;
  final String posNotifStan;
  final String posNotifInvoiceId;

  const PosCardPurchaseState({
    required this.purchaseAmount,
    required this.purchaseStatusCode,
    required this.purchaseMessage,
    required this.isLoading,
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
    required this.rrnAmount,
    required this.acctNo,
    required this.serialNo,
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
    required this.isInputEnabled,
  });

  PosCardPurchaseState copyWith({
    String? purchaseAmount,
    String? purchaseStatusCode,
    String? purchaseMessage,
    bool? isLoading,
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
    bool? isInputEnabled,
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
      rrnAmount: rrnAmount ?? this.rrnAmount,
      acctNo: acctNo ?? this.acctNo,
      serialNo: serialNo ?? this.serialNo,
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
      isInputEnabled: isInputEnabled ?? this.isInputEnabled,
    );
  }

  @override
  List<Object?> get props => [
    purchaseAmount,
    purchaseStatusCode,
    purchaseMessage,
    isLoading,
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
    rrnAmount,
    acctNo,
    serialNo,
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
    isInputEnabled,
  ];
}
