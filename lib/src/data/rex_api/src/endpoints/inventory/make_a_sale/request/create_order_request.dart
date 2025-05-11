import '../../../../utils/enums/payment_status.dart';

class CreateOrderRequest {
  final String orderNumber;
  final String? orderShortRef;
  final String merchantCode;
  final String storeCode;
  final String paymentMethod;
  final String currencyCode;
  final String customerId;
  final String customerName;
  final String? paymentStatus;
  final String soldBy;
  final double discount;
  final double totalAmount;
  final String? discountRef;
  final double totalTax;
  final double subTotal;
  final String transactionReference;
  final String deviceId;
  final String terminalId;
  final String geolocation;
  final String? remarks;
  final String? maskedCardNumber;
  final String? cardHolderName;
  final String? stan;
  final String? authCode;
  final String? responseCode;
  final String? responseDescription;
  final String? retrievalRefNumber;
  final String? cardScheme;
  final String? applicationVersion;
  final String? virtualAccountBankName;
  final String? virtualAccountNumber;
  final String? virtualAccountName;
  final List<CheckoutItem> checkoutItems;

  CreateOrderRequest({
    required this.orderNumber,
    this.orderShortRef,
    required this.merchantCode,
    required this.storeCode,
    required this.paymentMethod,
    required this.currencyCode,
    required this.customerId,
    required this.customerName,
    this.paymentStatus,
    required this.soldBy,
    required this.discount,
    required this.totalAmount,
    this.discountRef,
    required this.totalTax,
    required this.subTotal,
    required this.transactionReference,
    required this.deviceId,
    required this.terminalId,
    required this.geolocation,
     this.remarks,
     this.maskedCardNumber,
     this.cardHolderName,
     this.stan,
     this.authCode,
     this.responseCode,
     this.responseDescription,
     this.retrievalRefNumber,
     this.cardScheme,
     this.applicationVersion,
     this.virtualAccountBankName,
     this.virtualAccountNumber,
     this.virtualAccountName,
    required this.checkoutItems,
  });

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
    "orderShortRef": orderShortRef,
    "merchantCode": merchantCode,
    "storeCode": storeCode,
    "paymentMethod": paymentMethod,
    "currencyCode": currencyCode,
    "customerId": customerId,
    "customerName": customerName,
    "paymentStatus": PaymentStatus.paid.jsonString,
    "soldBy": soldBy,
    "discount": discount,
    "totalAmount": totalAmount,
    "discountRef": discountRef,
    "totalTax": totalTax,
    "subTotal": subTotal,
    "transactionReference": transactionReference,
    "orderChannel": 'MOBILE',
    "deviceId": deviceId,
    "terminalId": terminalId,
    "geolocation": geolocation,
    "remarks": remarks,
    "maskedCardNumber": maskedCardNumber,
    "cardHolderName": cardHolderName,
    "stan": stan,
    "authCode": authCode,
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "retrievalRefNumber": retrievalRefNumber,
    "cardScheme": cardScheme,
    "applicationVersion": applicationVersion,
    "virtualAccountBankName": virtualAccountBankName,
    "virtualAccountNumber": virtualAccountNumber,
    "virtualAccountName": virtualAccountName,
    "checkoutItems": List<dynamic>.from(checkoutItems.map((x) => x.toJson())),
  };
}

class CheckoutItem {
  final String productCode;
  final String productName;
  final String serialNo;
  final int quantity;
  final double unitAmount;
  final double discount;
  final double totalTax;

  CheckoutItem({
    required this.productCode,
    required this.productName,
    required this.serialNo,
    required this.quantity,
    required this.unitAmount,
    required this.discount,
    required this.totalTax,
  });

  Map<String, dynamic> toJson() => {
    "productCode": productCode,
    "productName": productName,
    "serialNo": serialNo,
    "quantity": quantity,
    "unitAmount": unitAmount,
    "discount": discount,
    "totalTax": totalTax,
  };
}
