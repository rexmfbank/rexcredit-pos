import 'dart:convert';

class BillersResponse {
  String responseCode;
  String responseMessage;
  BillerData data;

  BillersResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory BillersResponse.fromJson(Map<String, dynamic> json) =>
      BillersResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: BillerData.fromJson(json["data"]),
      );
}

class BillerData {
  String? categories;
  List<Biller>? billers;

  BillerData({
    this.categories,
    this.billers,
  });

  BillerData copyWith({
    String? categories,
    List<Biller>? billers,
  }) =>
      BillerData(
        categories: categories ?? this.categories,
        billers: billers ?? this.billers,
      );

  factory BillerData.fromRawJson(String str) =>
      BillerData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillerData.fromJson(Map<String, dynamic> json) => BillerData(
        categories: json["categories"],
        billers: json["billers"] == null
            ? []
            : List<Biller>.from(
                json["billers"]!.map((x) => Biller.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "billers": billers == null
            ? []
            : List<dynamic>.from(billers!.map((x) => x.toJson())),
      };
}

class Biller {
  String? entityCode;
  String? billerCode;
  String? billerName;
  String? billerShortName;
  String? billerDescription;
  String? billerCategoryCode;
  String? billerCategory;
  String? contactEmail;
  String? logoUrl;
  String? status;
  String? billerRef;
  int? id;
  String? countryCode;
  String? serviceProvider;
  List<BillerProduct>? products;
  List<PaymentDatum>? paymentData;
  num? agentCommission;
  num? networkCommission;
  num? serviceProviderCommission;
  num? platformCommission;
  num? aggregatorCommission;
  num? purchaseCommission;
  String? sharingType;
  num? minAmount;
  num? maxAmount;

  Biller({
    this.entityCode,
    this.billerCode,
    this.billerName,
    this.billerShortName,
    this.billerDescription,
    this.billerCategoryCode,
    this.billerCategory,
    this.contactEmail,
    this.logoUrl,
    this.status,
    this.billerRef,
    this.id,
    this.countryCode,
    this.serviceProvider,
    this.products,
    this.paymentData,
    this.agentCommission,
    this.networkCommission,
    this.serviceProviderCommission,
    this.platformCommission,
    this.aggregatorCommission,
    this.purchaseCommission,
    this.sharingType,
    this.minAmount,
    this.maxAmount,
  });

  Biller copyWith({
    String? entityCode,
    String? billerCode,
    String? billerName,
    String? billerShortName,
    String? billerDescription,
    String? billerCategoryCode,
    String? billerCategory,
    String? contactEmail,
    String? logoUrl,
    String? status,
    String? billerRef,
    int? id,
    String? countryCode,
    String? serviceProvider,
    List<BillerProduct>? products,
    List<PaymentDatum>? paymentData,
    num? agentCommission,
    num? networkCommission,
    num? serviceProviderCommission,
    num? platformCommission,
    num? aggregatorCommission,
    num? purchaseCommission,
    String? sharingType,
    num? minAmount,
    num? maxAmount,
  }) =>
      Biller(
        entityCode: entityCode ?? this.entityCode,
        billerCode: billerCode ?? this.billerCode,
        billerName: billerName ?? this.billerName,
        billerShortName: billerShortName ?? this.billerShortName,
        billerDescription: billerDescription ?? this.billerDescription,
        billerCategoryCode: billerCategoryCode ?? this.billerCategoryCode,
        billerCategory: billerCategory ?? this.billerCategory,
        contactEmail: contactEmail ?? this.contactEmail,
        logoUrl: logoUrl ?? this.logoUrl,
        status: status ?? this.status,
        billerRef: billerRef ?? this.billerRef,
        id: id ?? this.id,
        countryCode: countryCode ?? this.countryCode,
        serviceProvider: serviceProvider ?? this.serviceProvider,
        products: products ?? this.products,
        paymentData: paymentData ?? this.paymentData,
        agentCommission: agentCommission ?? this.agentCommission,
        networkCommission: networkCommission ?? this.networkCommission,
        serviceProviderCommission:
            serviceProviderCommission ?? this.serviceProviderCommission,
        platformCommission: platformCommission ?? this.platformCommission,
        aggregatorCommission: aggregatorCommission ?? this.aggregatorCommission,
        purchaseCommission: purchaseCommission ?? this.purchaseCommission,
        sharingType: sharingType ?? this.sharingType,
        minAmount: minAmount ?? this.minAmount,
        maxAmount: maxAmount ?? this.maxAmount,
      );

  factory Biller.fromRawJson(String str) => Biller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Biller.fromJson(Map<String, dynamic> json) => Biller(
        entityCode: json["entityCode"],
        billerCode: json["billerCode"],
        billerName: json["billerName"],
        billerShortName: json["billerShortName"],
        billerDescription: json["billerDescription"],
        billerCategoryCode: json["billerCategoryCode"],
        billerCategory: json["billerCategory"],
        contactEmail: json["contactEmail"],
        logoUrl: json["logoURL"],
        status: json["status"],
        billerRef: json["billerRef"],
        id: json["id"],
        countryCode: json["countryCode"],
        serviceProvider: json["serviceProvider"],
        products: json["products"] == null
            ? []
            : List<BillerProduct>.from(
                json["products"]!.map((x) => BillerProduct.fromJson(x))),
        paymentData: json["paymentData"] == null
            ? []
            : List<PaymentDatum>.from(
                json["paymentData"]!.map((x) => PaymentDatum.fromJson(x))),
        agentCommission: json["agentCommission"]?.toDouble(),
        networkCommission: json["networkCommission"]?.toDouble(),
        serviceProviderCommission:
            json["serviceProviderCommission"]?.toDouble(),
        platformCommission: json["platformCommission"]?.toDouble(),
        aggregatorCommission: json["aggregatorCommission"]?.toDouble(),
        purchaseCommission: json["purchaseCommission"]?.toDouble(),
        sharingType: json["sharingType"],
        minAmount: json["minAmount"],
        maxAmount: json["maxAmount"],
      );

  Map<String, dynamic> toJson() => {
        "entityCode": entityCode,
        "billerCode": billerCode,
        "billerName": billerName,
        "billerShortName": billerShortName,
        "billerDescription": billerDescription,
        "billerCategoryCode": billerCategoryCode,
        "billerCategory": billerCategory,
        "contactEmail": contactEmail,
        "logoURL": logoUrl,
        "status": status,
        "billerRef": billerRef,
        "id": id,
        "countryCode": countryCode,
        "serviceProvider": serviceProvider,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "paymentData": paymentData == null
            ? []
            : List<dynamic>.from(paymentData!.map((x) => x.toJson())),
        "agentCommission": agentCommission,
        "networkCommission": networkCommission,
        "serviceProviderCommission": serviceProviderCommission,
        "platformCommission": platformCommission,
        "aggregatorCommission": aggregatorCommission,
        "purchaseCommission": purchaseCommission,
        "sharingType": sharingType,
        "minAmount": minAmount,
        "maxAmount": maxAmount,
      };
}

class PaymentDatum {
  int? id;
  int? fieldId;
  String? fieldDataType;
  String? fieldName;
  String? fieldValue;
  String? fieldComment;
  String? lookupData;
  int? maxLength;
  String? mandatoryFlag;
  String? billerCode;

  PaymentDatum({
    this.id,
    this.fieldId,
    this.fieldDataType,
    this.fieldName,
    this.fieldValue,
    this.fieldComment,
    this.lookupData,
    this.maxLength,
    this.mandatoryFlag,
    this.billerCode,
  });

  PaymentDatum copyWith({
    int? id,
    int? fieldId,
    String? fieldDataType,
    String? fieldName,
    String? fieldValue,
    String? fieldComment,
    String? lookupData,
    int? maxLength,
    String? mandatoryFlag,
    String? billerCode,
  }) =>
      PaymentDatum(
        id: id ?? this.id,
        fieldId: fieldId ?? this.fieldId,
        fieldDataType: fieldDataType ?? this.fieldDataType,
        fieldName: fieldName ?? this.fieldName,
        fieldValue: fieldValue ?? this.fieldValue,
        fieldComment: fieldComment ?? this.fieldComment,
        lookupData: lookupData ?? this.lookupData,
        maxLength: maxLength ?? this.maxLength,
        mandatoryFlag: mandatoryFlag ?? this.mandatoryFlag,
        billerCode: billerCode ?? this.billerCode,
      );

  factory PaymentDatum.fromRawJson(String str) =>
      PaymentDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentDatum.fromJson(Map<String, dynamic> json) => PaymentDatum(
        id: json["id"],
        fieldId: json["fieldID"],
        fieldDataType: json["fieldDataType"],
        fieldName: json["fieldName"],
        fieldValue: json["fieldValue"],
        fieldComment: json["fieldComment"],
        lookupData: json["lookupData"],
        maxLength: json["maxLength"],
        mandatoryFlag: json["mandatoryFlag"],
        billerCode: json["billerCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fieldID": fieldId,
        "fieldDataType": fieldDataType,
        "fieldName": fieldName,
        "fieldValue": fieldValue,
        "fieldComment": fieldComment,
        "lookupData": lookupData,
        "maxLength": maxLength,
        "mandatoryFlag": mandatoryFlag,
        "billerCode": billerCode,
      };
}

class BillerProduct {
  int? id;
  String? productId;
  String? productCode;
  String? productDesc;
  String? productName;
  num? amount;
  String? amountType;
  num? charge;
  String? chargeType;
  String? status;
  String? paymentCode;
  String? paymentCode2;
  String? paymentCode3;
  String? billerCode;
  String? serviceProvider;
  double? costPrice;
  double? minAmount;
  double? maxAmount;
  num? agentCommission;
  num? networkCommission;
  num? serviceProviderCommission;
  num? platformCommission;
  num? aggregatorCommission;

  BillerProduct({
    this.id,
    this.productId,
    this.productCode,
    this.productDesc,
    this.productName,
    this.amount,
    this.amountType,
    this.charge,
    this.chargeType,
    this.status,
    this.paymentCode,
    this.paymentCode2,
    this.paymentCode3,
    this.billerCode,
    this.serviceProvider,
    this.costPrice,
    this.minAmount,
    this.maxAmount,
    this.agentCommission,
    this.networkCommission,
    this.serviceProviderCommission,
    this.platformCommission,
    this.aggregatorCommission,
  });

  BillerProduct copyWith({
    int? id,
    String? productId,
    String? productCode,
    String? productDesc,
    String? productName,
    num? amount,
    String? amountType,
    num? charge,
    String? chargeType,
    String? status,
    String? paymentCode,
    String? paymentCode2,
    String? paymentCode3,
    String? billerCode,
    String? serviceProvider,
    double? costPrice,
    double? minAmount,
    double? maxAmount,
    num? agentCommission,
    num? networkCommission,
    num? serviceProviderCommission,
    num? platformCommission,
    num? aggregatorCommission,
  }) =>
      BillerProduct(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productCode: productCode ?? this.productCode,
        productDesc: productDesc ?? this.productDesc,
        productName: productName ?? this.productName,
        amount: amount ?? this.amount,
        amountType: amountType ?? this.amountType,
        charge: charge ?? this.charge,
        chargeType: chargeType ?? this.chargeType,
        status: status ?? this.status,
        paymentCode: paymentCode ?? this.paymentCode,
        paymentCode2: paymentCode2 ?? this.paymentCode2,
        paymentCode3: paymentCode3 ?? this.paymentCode3,
        billerCode: billerCode ?? this.billerCode,
        serviceProvider: serviceProvider ?? this.serviceProvider,
        costPrice: costPrice ?? this.costPrice,
        minAmount: minAmount ?? this.minAmount,
        maxAmount: maxAmount ?? this.maxAmount,
        agentCommission: agentCommission ?? this.agentCommission,
        networkCommission: networkCommission ?? this.networkCommission,
        serviceProviderCommission:
            serviceProviderCommission ?? this.serviceProviderCommission,
        platformCommission: platformCommission ?? this.platformCommission,
        aggregatorCommission: aggregatorCommission ?? this.aggregatorCommission,
      );

  factory BillerProduct.fromRawJson(String str) =>
      BillerProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillerProduct.fromJson(Map<String, dynamic> json) => BillerProduct(
        id: json["id"],
        productId: json["productId"],
        productCode: json["productCode"],
        productDesc: json["productDesc"],
        productName: json["productName"],
        amount: json["amount"],
        amountType: json["amountType"],
        charge: json["charge"]?.toDouble(),
        chargeType: json["chargeType"],
        status: json["status"],
        paymentCode: json["paymentCode"],
        paymentCode2: json["paymentCode2"],
        paymentCode3: json["paymentCode3"],
        billerCode: json["billerCode"],
        serviceProvider: json["serviceProvider"],
        costPrice: json["costPrice"],
        minAmount: json["minAmount"],
        maxAmount: json["maxAmount"],
        agentCommission: json["agentCommission"]?.toDouble(),
        networkCommission: json["networkCommission"],
        serviceProviderCommission:
            json["serviceProviderCommission"]?.toDouble(),
        platformCommission: json["platformCommission"]?.toDouble(),
        aggregatorCommission: json["aggregatorCommission"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productCode": productCode,
        "productDesc": productDesc,
        "productName": productName,
        "amount": amount,
        "amountType": amountType,
        "charge": charge,
        "chargeType": chargeType,
        "status": status,
        "paymentCode": paymentCode,
        "paymentCode2": paymentCode2,
        "paymentCode3": paymentCode3,
        "billerCode": billerCode,
        "serviceProvider": serviceProvider,
        "costPrice": costPrice,
        "minAmount": minAmount,
        "maxAmount": maxAmount,
        "agentCommission": agentCommission,
        "networkCommission": networkCommission,
        "serviceProviderCommission": serviceProviderCommission,
        "platformCommission": platformCommission,
        "aggregatorCommission": aggregatorCommission,
      };
}
