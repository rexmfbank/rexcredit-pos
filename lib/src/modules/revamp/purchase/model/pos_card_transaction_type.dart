enum PosCardTransactionType {
  purchase(
    key: "PURCHASE",
    description: "Normal purchase transaction",
  ),
  purchaseWithCb(
    key: "PURCHASEWITHCB",
    description: "Purchase transaction with cashback",
  ),
  balance(
    key: "BALANCE",
    description: "Check card balance",
  ),
  preAuth(
    key: "PREAUTH",
    description: "Pre-authorization transaction",
  ),
  preAuthComplete(
    key: "PREAUTHCOMPLETE",
    description: "Pre-authorization completion transaction",
  ),
  refund(
    key: "REFUND",
    description: "Refund transaction",
  ),
  cashAdvance(
    key: "CASHADVANCE",
    description: "Cash advance transaction",
  ),
  reversal(
    key: "REVERSAL",
    description: "Reversal transaction for an unsettled transaction",
  );

  final String key;
  final String description;

  const PosCardTransactionType({
    required this.key,
    required this.description,
  });
}
