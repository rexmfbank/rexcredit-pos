
class PostBillPaymentRequest {
  String? username;
  String? accountNo;
  String? deviceId;
  String? productCode;
  String? ccy;
  String? address;
  num? amount;
  num? charge;
  String? narration;
  String? merchantId;
  String? tranCode;
  String? tranType;
  String? userId;
  String? mobileNo;
  String? paymentMethod;
  String? serviceProvider;
  String? billerCode;
  String? terminalId;
  String? entityCode;
  String? cardData;
  String? customerName;
  String? billRefNo;
  String? geolocation;
  String? externalRefNo;
  String? channelType;
  bool? saveBeneficiary;
  List<PaymentDataList>? paymentDataList;

  PostBillPaymentRequest({
    this.username,
    this.accountNo,
    this.deviceId,
    this.productCode,
    this.ccy,
    this.address,
    this.amount,
    this.charge,
    this.narration,
    this.merchantId,
    this.tranCode,
    this.tranType,
    this.userId,
    this.mobileNo,
    this.paymentMethod,
    this.serviceProvider,
    this.billerCode,
    this.terminalId,
    this.entityCode,
    this.cardData,
    this.customerName,
    this.billRefNo,
    this.geolocation,
    this.externalRefNo,
    this.channelType,
    this.saveBeneficiary,
    this.paymentDataList,
  });

  PostBillPaymentRequest copyWith({
    String? username,
    String? accountNo,
    String? deviceId,
    String? productCode,
    String? ccy,
    String? address,
    num? amount,
    num? charge,
    String? narration,
    String? merchantId,
    String? tranCode,
    String? tranType,
    String? userId,
    String? mobileNo,
    String? paymentMethod,
    String? serviceProvider,
    String? billerCode,
    String? terminalId,
    String? entityCode,
    String? cardData,
    String? customerName,
    String? billRefNo,
    String? geolocation,
    String? externalRefNo,
    String? channelType,
    bool? saveBeneficiary,
    List<PaymentDataList>? paymentDataList,
  }) =>
      PostBillPaymentRequest(
        username: username ?? this.username,
        accountNo: accountNo ?? this.accountNo,
        deviceId: deviceId ?? this.deviceId,
        productCode: productCode ?? this.productCode,
        ccy: ccy ?? this.ccy,
        address: address ?? this.address,
        amount: amount ?? this.amount,
        charge: charge ?? this.charge,
        narration: narration ?? this.narration,
        merchantId: merchantId ?? this.merchantId,
        tranCode: tranCode ?? this.tranCode,
        tranType: tranType ?? this.tranType,
        userId: userId ?? this.userId,
        mobileNo: mobileNo ?? this.mobileNo,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        serviceProvider: serviceProvider ?? this.serviceProvider,
        billerCode: billerCode ?? this.billerCode,
        terminalId: terminalId ?? this.terminalId,
        entityCode: entityCode ?? this.entityCode,
        cardData: cardData ?? this.cardData,
        customerName: customerName ?? this.customerName,
        billRefNo: billRefNo ?? this.billRefNo,
        geolocation: geolocation ?? this.geolocation,
        externalRefNo: externalRefNo ?? this.externalRefNo,
        channelType: channelType ?? this.channelType,
        saveBeneficiary: saveBeneficiary ?? this.saveBeneficiary,
        paymentDataList: paymentDataList ?? this.paymentDataList,
      );

  Map<String, dynamic> toJson() => {
    "username": username,
    "accountNo": accountNo,
    "deviceId": deviceId,
    "productCode": productCode,
    "ccy": ccy,
    "address": address,
    "amount": amount,
    "charge": charge,
    "narration": narration,
    "merchantId": merchantId,
    "tranCode": tranCode,
    "tranType": tranType,
    "userID": userId,
    "mobileNo": mobileNo,
    "paymentMethod": paymentMethod,
    "serviceProvider": serviceProvider,
    "billerCode": billerCode,
    "terminalId": terminalId,
    "entityCode": entityCode,
    "cardData": cardData,
    "customerName": customerName,
    "billRefNo": billRefNo,
    "geolocation": geolocation,
    "externalRefNo": externalRefNo,
    "channelType": channelType,
    "saveBeneficiary": saveBeneficiary,
    "paymentDataList": paymentDataList == null ? [] : List<dynamic>.from(paymentDataList!.map((x) => x.toJson())),
  };
}

class PaymentDataList {
  int? id;
  String? fieldId;
  String? fieldDataType;
  String? fieldName;
  String? fieldValue;
  String? fieldComment;
  String? lookupData;
  int? maxLength;
  String? mandatoryFlag;
  String? billerCode;

  PaymentDataList({
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

  PaymentDataList copyWith({
    int? id,
    String? fieldId,
    String? fieldDataType,
    String? fieldName,
    String? fieldValue,
    String? fieldComment,
    String? lookupData,
    int? maxLength,
    String? mandatoryFlag,
    String? billerCode,
  }) =>
      PaymentDataList(
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
