import 'package:rex_app/src/modules/api/rex_api.dart';

abstract class ApiPath {
  // Base URLs
  static final baseUrl = ApiConfig.shared.baseUrl;
  static final imageBaseUrl = ApiConfig.shared.imageBaseUrl;

  static final checkEncryption = '$baseUrl/app-config';

  /// ENDPOINTS: Outside Screens
  static posTsq(String rrn) => '$baseUrl/pos/check-status?rrn=$rrn';
  static posAuth(String serialNo) =>
      "$baseUrl/pos/get-identity?serialNo=$serialNo";
  static posTransactions(String serialNo) =>
      "$baseUrl/pos/transactions?serialNo=$serialNo";
  static posRequery(String ref) => "$baseUrl/pos/requery?transUniqueRef=$ref";
  static final posQuickPurchase = "$baseUrl/pos/quick-purchase";
  static final posCreateDispute = '$baseUrl/pos/dispute/save';
  static final posFetchDispute = '$baseUrl/pos/dispute/list';
  static final posDisputeReasons = '$baseUrl/pos/dispute/reasons';
  static final posRetrieveRRN = '$baseUrl/pos/pre-quick-purchase';
  static final posNfcPurchase = '$baseUrl/pos/nfc/debit';

  // Transaction
  static final miniStatement = '$baseUrl/transaction/mini/statement';
  static final createDispute = '$baseUrl/dispute/save';
  static final fetchDispute = '$baseUrl/dispute/fetch';

  /// ENDPOINTS: Inside Screens
  static final login = "$baseUrl/customer/login";
  static final verifyLocationOtp = "$baseUrl/customer/verify-location-otp";
  static final sendOtp = "$baseUrl/send-otp";
  static final passwordReset = "$baseUrl/password/reset";
  static final nameInquiry = "$baseUrl/name-inquiry";
  static final sendMoney = "$baseUrl/send-money";
  static final balance = "$baseUrl/get-balance";
  static final profile = "$baseUrl/borrower/profile";
  static final changePassword = "$baseUrl/borrower/change-password";
  static final bankList = "$baseUrl/banks";

  /// TODO: do not call this two endpoints again,
  /// use only /pos/transactions
  static final getTransactions = "$baseUrl/wallet/transaction-history"; 
  static transactionQuery(String ref) => "$baseUrl/wallet/transaction/$ref";
}
