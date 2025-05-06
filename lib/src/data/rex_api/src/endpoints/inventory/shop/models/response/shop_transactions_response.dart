class ShopTransactionsResponse {
  final String? responseCode;
  final String? responseMessage;
  final List<ShopTransactions>? data;
  final int? pageIndex;
  final int? pageSize;
  final int? totalPages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final int? totalContent;

  ShopTransactionsResponse({
    this.responseCode,
    this.responseMessage,
    this.data,
    this.pageIndex,
    this.pageSize,
    this.totalPages,
    this.hasNextPage,
    this.hasPreviousPage,
    this.totalContent,
  });

  factory ShopTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      ShopTransactionsResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => ShopTransactions.fromJson(e))
                .toList(),
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
        totalPages: json["totalPages"],
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
        totalContent: json["totalContent"],
      );
}

class ShopTransactions {
  final Order? order;
  final List<Item>? orderItems;

  ShopTransactions({
    this.order,
    this.orderItems,
  });

  factory ShopTransactions.fromJson(Map<String, dynamic> json) =>
      ShopTransactions(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        orderItems: json["orderItems"] == null
            ? []
            : (json["orderItems"] as List)
                .map((e) => Item.fromJson(e))
                .toList(),
      );
}

class Order {
  final DateTime? createdDate;
  final String? createdBy;
  final String? modifiedBy;
  final DateTime? modifiedDate;
  final int? id;
  final String? orderNumber;
  final String? orderShortRef;
  final int? totalQuantity;
  final double? totalAmount;
  final String? direction;
  final String? entityCode;
  final String? merchantCode;
  final String? storeCode;
  final String? paymentMethod;
  final String? currencyCode;
  final String? customerId;
  final String? customerName;
  final String? paymentStatus;
  final String? soldBy;
  final double? discount;
  final String? discountRef;
  final String? totalTax;
  final double? taxAmount1;
  final double? taxAmount2;
  final double? taxAmount3;
  final double? amountOwed;
  final String? subTotal;
  final String? transactionReference;
  final String? orderChannel;
  final String? deviceId;
  final String? terminalId;
  final String? geolocation;
  final String? status;
  final String? remarks;
  final String? verifiedDate;
  final String? verifiedBy;
  final String? verifiedStatus;
  final bool? orderCancelled;
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

  Order({
    this.createdDate,
    this.createdBy,
    this.modifiedBy,
    this.modifiedDate,
    this.id,
    this.orderNumber,
    this.orderShortRef,
    this.totalQuantity,
    this.totalAmount,
    this.direction,
    this.entityCode,
    this.merchantCode,
    this.storeCode,
    this.paymentMethod,
    this.currencyCode,
    this.customerId,
    this.customerName,
    this.paymentStatus,
    this.soldBy,
    this.discount,
    this.discountRef,
    this.totalTax,
    this.taxAmount1,
    this.taxAmount2,
    this.taxAmount3,
    this.amountOwed,
    this.subTotal,
    this.transactionReference,
    this.orderChannel,
    this.deviceId,
    this.terminalId,
    this.geolocation,
    this.status,
    this.remarks,
    this.verifiedDate,
    this.verifiedBy,
    this.verifiedStatus,
    this.orderCancelled,
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
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.tryParse(json["createdDate"]),
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"] == null
            ? null
            : DateTime.tryParse(json["modifiedDate"]),
        id: json["id"],
        orderNumber: json["orderNumber"],
        orderShortRef: json["orderShortRef"],
        totalQuantity: json["totalQuantity"],
        totalAmount: json["totalAmount"],
        direction: json["direction"],
        entityCode: json["entityCode"],
        merchantCode: json["merchantCode"],
        storeCode: json["storeCode"],
        paymentMethod: json["paymentMethod"],
        currencyCode: json["currencyCode"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        paymentStatus: json["paymentStatus"],
        soldBy: json["soldBy"],
        discount: json["discount"],
        discountRef: json["discountRef"],
        totalTax: json["totalTax"],
        taxAmount1: json["taxAmount1"],
        taxAmount2: json["taxAmount2"],
        taxAmount3: json["taxAmount3"],
        amountOwed: json["amountOwed"],
        subTotal: json["subTotal"],
        transactionReference: json["transactionReference"],
        orderChannel: json["orderChannel"],
        deviceId: json["deviceId"],
        terminalId: json["terminalId"],
        geolocation: json["geolocation"],
        status: json["status"],
        remarks: json["remarks"],
        verifiedDate: json["verifiedDate"],
        verifiedBy: json["verifiedBy"],
        verifiedStatus: json["verifiedStatus"],
        orderCancelled: json["orderCancelled"],
        maskedCardNumber: json["maskedCardNumber"],
        cardHolderName: json["cardHolderName"],
        stan: json["stan"],
        authCode: json["authCode"],
        responseCode: json["responseCode"],
        responseDescription: json["responseDescription"],
        retrievalRefNumber: json["retrievalRefNumber"],
        cardScheme: json["cardScheme"],
        applicationVersion: json["applicationVersion"],
        virtualAccountBankName: json["virtualAccountBankName"],
        virtualAccountNumber: json["virtualAccountNumber"],
        virtualAccountName: json["virtualAccountName"],
      );
}

class Item {
  final int? id;
  final String? orderNumber;
  final String? serialNo;
  final String? productCode;
  final String? productName;
  final int? quantity;
  final int? unitAmount;
  final int? discount;
  final int? totalTax;
  final String? barcode;

  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderNumber: json["orderNumber"],
        serialNo: json["serialNo"],
        productCode: json["productCode"],
        productName: json["productName"],
        quantity: json["quantity"],
        unitAmount: json["unitAmount"],
        discount: json["discount"],
        totalTax: json["totalTax"],
        barcode: json["barcode"],
      );
}
