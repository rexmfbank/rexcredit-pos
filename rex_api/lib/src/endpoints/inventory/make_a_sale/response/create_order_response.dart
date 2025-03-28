import 'package:rex_api/src/utils/enums/enums.dart';
import 'package:rex_api/src/utils/enums/payment_status.dart';

class CreateOrderResponse {
  final String responseCode;
  final String responseMessage;
  final CreateOrderInfo? data;

  CreateOrderResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null ? null : CreateOrderInfo.fromJson(json["data"]),
      );
}

class CreateOrderInfo {
  final int? id;
  final String? orderNumber;
  final String? merchantCode;
  final String? storeCode;
  final PaymentMethod? paymentMethod;
  final String? currencyCode;
  final String? customerId;
  final String? customerName;
  final PaymentStatus? paymentStatus;
  final String? soldBy;
  final double? discount;
  final String? totalTax;
  final String? subTotal;
  final String? transactionReference;
  final String? orderChannel;
  final String? deviceId;
  final String? terminalId;
  final String? geolocation;
  final String? status;
  final List<OrderItem>? orderItems;

  CreateOrderInfo({
    this.id,
    this.orderNumber,
    this.merchantCode,
    this.storeCode,
    this.paymentMethod,
    this.currencyCode,
    this.customerId,
    this.customerName,
    this.paymentStatus,
    this.soldBy,
    this.discount,
    this.totalTax,
    this.subTotal,
    this.transactionReference,
    this.orderChannel,
    this.deviceId,
    this.terminalId,
    this.geolocation,
    this.status,
    this.orderItems,
  });

  factory CreateOrderInfo.fromJson(Map<String, dynamic> json) =>
      CreateOrderInfo(
        id: json["id"],
        orderNumber: json["orderNumber"],
        merchantCode: json["merchantCode"],
        storeCode: json["storeCode"],
        paymentMethod: (json["paymentMethod"] as String?).paymentMethod,
        currencyCode: json["currencyCode"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        paymentStatus: (json["paymentStatus"] as String?).paymentStatus,
        soldBy: json["soldBy"],
        discount: json["discount"],
        totalTax: json["totalTax"],
        subTotal: json["subTotal"],
        transactionReference: json["transactionReference"],
        orderChannel: json["orderChannel"],
        deviceId: json["deviceId"],
        terminalId: json["terminalId"],
        geolocation: json["geolocation"],
        status: json["status"],
        orderItems: json["orderItems"] == null ? [] : List<OrderItem>.from(
            json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
      );

}

class OrderItem {
  final int? id;
  final String? orderNumber;
  final String? serialNo;
  final String? productCode;
  final String? productName;
  final int? quantity;
  final double? unitAmount;
  final double? discount;
  final double? totalTax;
  final String? barcode;

  OrderItem({
    this.id,
    this.orderNumber,
    this.serialNo,
    this.productCode,
    this.productName,
    this.quantity,
    this.unitAmount,
    this.discount,
    this.totalTax,
    this.barcode,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"] ?? 0,
    orderNumber: json["orderNumber"] ?? '',
    serialNo: json["serialNo"] ?? '',
    productCode: json["productCode"] ?? '',
    productName: json["productName"] ?? '',
    quantity: json["quantity"] ?? 0,
    unitAmount: json["unitAmount"] ?? 0,
    discount: json["discount"] ?? 0,
    totalTax: json["totalTax"] ?? 0,
    barcode: json["barcode"] ?? '',
  );
}
