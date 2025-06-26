import 'dart:convert';

IntentUtilityResponse intentUtilityResponseFromJson(String str) =>
    IntentUtilityResponse.fromJson(json.decode(str));

String intentUtilityResponseToJson(IntentUtilityResponse data) =>
    json.encode(data.toJson());

class IntentUtilityResponse {
  final String? billerId;
  final String? merchantId;
  final String? terminalId;
  final String? serialNumber;
  final String? ptsp;
  final String? footerMessage;
  final String? state;
  final String? city;
  final String? merchantName;
  final String? merchantAddress;
  final String? bankName;
  final String? bankLogo;
  final String? merchantCategoryCode;
  final String? baseAppVersion;
  final String? currency;

  IntentUtilityResponse({
    this.billerId,
    this.merchantId,
    this.terminalId,
    this.serialNumber,
    this.ptsp,
    this.footerMessage,
    this.state,
    this.city,
    this.merchantName,
    this.merchantAddress,
    this.bankName,
    this.bankLogo,
    this.merchantCategoryCode,
    this.baseAppVersion,
    this.currency,
  });

  factory IntentUtilityResponse.fromJson(Map<String, dynamic> json) =>
      IntentUtilityResponse(
        billerId: json["Biller_ID"],
        merchantId: json["MerchantID"],
        terminalId: json["TerminalID"],
        serialNumber: json["serialNumber"],
        ptsp: json["PTSP"],
        footerMessage: json["FooterMessage"],
        state: json["State"],
        city: json["City"],
        merchantName: json["MerchantName"],
        merchantAddress: json["MerchantAddress"],
        bankName: json["BankName"],
        bankLogo: json["BankLogo"],
        merchantCategoryCode: json["MerchantCategoryCode"],
        baseAppVersion: json["baseAppVersion"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "Biller_ID": billerId,
        "MerchantID": merchantId,
        "TerminalID": terminalId,
        "serialNumber": serialNumber,
        "PTSP": ptsp,
        "FooterMessage": footerMessage,
        "State": state,
        "City": city,
        "MerchantName": merchantName,
        "MerchantAddress": merchantAddress,
        "BankName": bankName,
        "BankLogo": bankLogo,
        "MerchantCategoryCode": merchantCategoryCode,
        "baseAppVersion": baseAppVersion,
        "currency": currency,
      };

  @override
  String toString() => "IntentUtilityResponse ${toJson()}";
}
