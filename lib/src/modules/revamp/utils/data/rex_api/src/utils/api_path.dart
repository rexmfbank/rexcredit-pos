import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

abstract class ApiPath {
  // Base URLs
  static final baseUrl = ApiConfig.shared.baseUrl;
  static final imageBaseUrl = ApiConfig.shared.imageBaseUrl;

  // POS TERMINAL ENDPOINTS
  static posAuth(String serialNo) =>
      "$baseUrl/pos/get-identity?serialNo=$serialNo";
  static final posTransactions = "$baseUrl/pos/transaction";
  static final posQuickPurchase = "$baseUrl/pos/quick-purchase";
  static final posCreateDispute = '$baseUrl/pos/dispute/save';
  static final posFetchDispute = '$baseUrl/pos/dispute/fetch';

  // Utility
  static final state = '$baseUrl/v2/state';
  static final lga = '$baseUrl/v2/lga/'; // pass State Id as params

  //Update
  static final forceUpdate = '$baseUrl/param/forceupdate';

  // Profile
  static final addNextOfKin = '$baseUrl/next-of-kin/add';
  static final fetchNextOfKin = '$baseUrl/next-of-kin/view';
  static final viewSecurityQuestion = '$baseUrl/security-question/view';
  static final saveSecurityQuestion = '$baseUrl/security-question/store';
  static final verifySecurityQuestion = '$baseUrl/security-question/verify';
  static final validateTransactionPin =
      '$baseUrl/security-question/pinValidation';

  //Lookup Data
  static final fetchlookupDataByCode = '$baseUrl/lookupdata/listlookupdata';
  static final fetchBaLookupData = '$baseUrl/lookupdata/getbalookupdata';
  static final fetchLookupListData = '$baseUrl/lookupdata/listlookupdata';

  // User Manager
  static final verifyOtp = '$baseUrl/usermanager/v2/verifyotp';
  static final verifyNewDevice = '$baseUrl/usermanager/v2/verifyotp-device';
  static final updateUser = '$baseUrl/usermanager/updateUser';
  static final setTransactionPin = '$baseUrl/usermanager/setTransactionPin';
  static final setTransactionPinV2 =
      '$baseUrl/usermanager/v2/setTransactionPin';
  static final selfPasswordReset = '$baseUrl/usermanager/selfPasswordReset';
  static final selfPasswordResetV2 =
      '$baseUrl/usermanager/v2/selfPasswordReset';
  static final login = '$baseUrl/usermanager/v2/login';
  static final changePIN = '$baseUrl/usermanager/changePIN';
  static final changePINV2 = '$baseUrl/usermanager/v2/changePIN';
  static final changeTransactionPIN =
      '$baseUrl/usermanager/changeTransactionPIN';
  static final changeTransactionPINV2 =
      '$baseUrl/usermanager/v2/changeTransactionPIN';
  static final address = '$baseUrl/usermanager/address';
  static final getProfile = '$baseUrl/usermanager/profile';
  static initiateTransactionPinReset(String entityCode, String username) =>
      "$baseUrl/usermanager/initiateTransactionPinReset/?entityCode=$entityCode&username=$username";
  static final initiateTransationPinResetV2 =
      "$baseUrl/usermanager/v2/initiateTransactionPinReset";
  static final resetTransactionPin = "$baseUrl/usermanager/selfTransPinReset";
  static final resetTransactionPinV2 =
      "$baseUrl/usermanager/v2/selfTransPinReset";
  static final resendOtp = "$baseUrl/usermanager/v2/resendotp";
  static initiatePasswordReset(String entityCode, String username) =>
      "$baseUrl/usermanager/initiatePasswordReset?entityCode=$entityCode&username=$username";
  static final initiatePasswordResetV2 =
      "$baseUrl/usermanager/v2/initiatePasswordReset";
  static final deactivateAccount = '$baseUrl/usermanager/deactivate';
  static final customerLimit = '$baseUrl/usermanager/customer-limit';

  // Lookup Data
  static listLookupData(
    String lookupCode,
    String entityCode,
    String parentCode,
  ) =>
      "$baseUrl/lookupdata/listlookupdata?entityCode=$entityCode&lookupCode=$lookupCode&parentCode=$parentCode";
  static getAllCategoryCode(String categoryCode) =>
      "$baseUrl/lookupdata/getallcategorycode?categoryCode=$categoryCode";
  static final appCountries = '$baseUrl/lookupdata/appCountries';
  static final termsConditionAndPolicy =
      '$baseUrl/lookupdata/termConditionAndPolicy';
  static final contactCare = '$baseUrl/lookupdata/contactCare';

  //Bank Transfer
  static final getBanks = '$baseUrl/lookupdata/banks?countryCode=NG';
  static final completeTransfer = '$baseUrl/transfer/interbankFundTransfer';
  static final completeTransferV2 =
      '$baseUrl/transfer/v2/interbankFundTransfer';
  // Transfer
  static final internalTransfer = '$baseUrl/transfer/internalTransfer';
  static final internalTransferV2 = '$baseUrl/transfer/v2/internalTransfer';
  static final internalTSQ = '$baseUrl/transfer/internalTSQ';
  static final internalAccountLookUp =
      '$baseUrl/transfer/internalAccountLookUp';
  static final interAccountLookUp = '$baseUrl/transfer/interbankAccountLookUp';
  static final internalBalanceEnquiry =
      '$baseUrl/transfer/internalBalanceEnquiry';
  static final bankUptime = '$baseUrl/bankuptime';

  // Transaction
  static final miniStatement = '$baseUrl/transaction/mini/statement';
  static final createDispute = '$baseUrl/dispute/save';
  static final fetchDispute = '$baseUrl/dispute/fetch';
  static final saveBeneficiary = '$baseUrl/transbeneficiary/save';
  static final searchBeneficiary = '$baseUrl/transbeneficiary/search';
  static final fetchBeneficiary = '$baseUrl/transbeneficiary';
  static final deleteBeneficiary = '$baseUrl/transbeneficiary/delete';
  static final bankStatement = '$baseUrl/transaction/statement';

  ///Notification-History
  static final getAllNotifications = '$baseUrl/push-notification';
  static final deleteAllNotifications = '$baseUrl/push-notification';
  static final updateNotificationStatus =
      '$baseUrl/push-notification/update-status';

  // Card purchase
  static final cardPurchase = "$baseUrl/transHistory/card";

  // BA account
  static final topUp = '$baseUrl/baaccount/top-up';
  static final topUpV2 = '$baseUrl/baaccount/v2/top-up';
  static final setWithdrawalLimit = '$baseUrl/baaccount/set-withdrawal-limit';

  //Bill Payment
  static final validateBill = '$baseUrl/billpayment/validatebill';
  static final postBillPayment = '$baseUrl/billpayment/postbillpayment';
  static final postBillPaymentV2 = '$baseUrl/billpayment/v2/postbillpayment';
  static final getBillerCategories = '$baseUrl/billpayment/getBillerCategories';
  static final getBillers = '$baseUrl/billpayment/getbillers';
  static final getAllBillers = '$baseUrl/billpayment/getbillersall';
  static final getTransactionBeneficiary = '$baseUrl/transbeneficiary';

  // Referrals
  static fetchReferrals(String code) => "$baseUrl/referral?referralCode=$code";

  //Request POS
  static final requestPOS = '$baseUrl/pos/request';
}
