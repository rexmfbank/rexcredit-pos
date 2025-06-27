import 'package:equatable/equatable.dart';

class KeyExchangeResult extends Equatable {
  final String? ptsp;
  final String? merchantName;
  final String? merchantCategoryCode;
  final String? serialNumber;
  final String? merchantId;
  final String? baseAppVersion;
  final String? terminalId;
  final String? location;

  const KeyExchangeResult({
    this.ptsp,
    this.merchantName,
    this.merchantCategoryCode,
    this.serialNumber,
    this.merchantId,
    this.baseAppVersion,
    this.terminalId,
    this.location,
  });

  factory KeyExchangeResult.fromJson(Map<String, dynamic> json) {
    return KeyExchangeResult(
      ptsp: json['PTSP'],
      merchantName: json['MerchantName'],
      merchantCategoryCode: json['MerchantCategoryCode'],
      serialNumber: json['serialNumber'],
      merchantId: json['MerchantID'],
      baseAppVersion: json['baseAppVersion'],
      terminalId: json['TerminalID'],
      location: json['Location'],
    );
  }

  @override
  String toString() =>
      "KeyExchangeResult: $ptsp, $merchantName, $merchantCategoryCode,$serialNumber, $merchantId, $baseAppVersion, $terminalId, $location";

  @override
  List<Object?> get props => [
        ptsp,
        merchantName,
        merchantCategoryCode,
        serialNumber,
        merchantId,
        baseAppVersion,
        terminalId,
        location,
      ];
}

 /*
  {"add_act_to_rcpt":" 0",
  "PTSP":"Global Accelerex",
  "enable_contactless":"1",
  "01000058":"1",
  "enable_refund":"1",
  "enable_ssl":"1",
  "enable_transfer":"1",
  "enable_reversal":"1",
  "MerchantName":"REXBANK TEST MERCHANT",
  "anp_base_url":"",
  "MerchantCategoryCode":"5399",
  "currency":"NGN",
  "enable_purchase_cb":"1",
  "enable_balance":"1",
  "anp_client_secret":"",
  "terminalCapability":"E0F8E8",
  "BankLogo":"https://ga-pos-banklogos.s3-eu-west-1.amazonaws.com/2035.png",
  "anp_entity_code":"",
  "serialNumber":"N820W333888",
  "enable_pre_auth":"1",
  "MerchantID":"2035LA133036217",
  "anp_source_code":"",
  "terminalType":"22",
  "baseAppVersion":"Accelerex-NG 2.0.5-20250131",
  "ClientSecret":"12",
  "FooterMessage":"",
  "anp_client_id":"",
  "TerminalID":"203532FV",
  "enable_purchase":"1",
  "enableAutoAccountSelection":"0",
  "enable_cash_advance":"0",
  "Location":"avbabeBearb",
  "DisablePWCB":""}
   */
