import 'package:rex_app/src/modules/revamp/api/rex_api.dart';

abstract class ApiPath {
  // Base URLs
  static final baseUrl = ApiConfig.shared.baseUrl;
  static final imageBaseUrl = ApiConfig.shared.imageBaseUrl;

  // POS TERMINAL ENDPOINTS
  static posAuth(String serialNo) =>
      "$baseUrl/pos/get-identity?serialNo=$serialNo";
  //static final posTransactions = "$baseUrl/pos/transaction";
  static posTransactions(String serialNo) =>
      "$baseUrl/pos/transactions?serialNo=$serialNo";
  static final posQuickPurchase = "$baseUrl/pos/quick-purchase";
  static final posCreateDispute = '$baseUrl/pos/dispute/save';
  static final posFetchDispute = '$baseUrl/pos/dispute/fetch';
  static final posRetreiveRRN = '$baseUrl/pos/pre-quick-purchase';
  static posTsq(String rrn) => '$baseUrl/pos/check-status?rrn=$rrn';
  static final posNfcPurchase = '$baseUrl/pos/nfc/debit';

  // Transaction
  static final miniStatement = '$baseUrl/transaction/mini/statement';
  static final createDispute = '$baseUrl/dispute/save';
  static final fetchDispute = '$baseUrl/dispute/fetch';
}
