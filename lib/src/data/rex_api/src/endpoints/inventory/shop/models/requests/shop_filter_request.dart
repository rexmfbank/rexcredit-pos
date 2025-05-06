class ShopFilterRequest {
  final String? merchantCode;
  final String? orderNumber;
  final String? orderShortRef;
  final String? storeCode;
  final String? customerId;
  final String? paymentStatus;
  final String? deviceId;
  final String? terminalId;
  final String? startDate;
  final String? endDate;
  final String? status;
  final int? pageIndex;
  final int? pageSize;

  ShopFilterRequest({
    this.merchantCode,
    this.orderNumber,
    this.orderShortRef,
    this.storeCode,
    this.customerId,
    this.paymentStatus,
    this.deviceId,
    this.terminalId,
    this.startDate,
    this.endDate,
    this.status,
    this.pageIndex,
    this.pageSize,
  });

  Map<String, dynamic> toJson() => {
    "merchantCode": merchantCode,
    "orderNumber": orderNumber,
    "orderShortRef": orderShortRef,
    "storeCode": storeCode,
    "customerId": customerId,
    "paymentStatus": paymentStatus,
    "deviceId": deviceId,
    "terminalId": terminalId,
    "startDate": startDate,
    "endDate": endDate,
    "status": status,
    "pageIndex": pageIndex ?? 15,
    "pageSize": pageSize ?? 10,
  };
}
