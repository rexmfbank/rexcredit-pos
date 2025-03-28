import 'package:rex_api/rex_api.dart';

abstract class ApiPath {
  // Base URLs
  static final baseUrl = ApiConfig.shared.baseUrl;
  static final imageBaseUrl = ApiConfig.shared.imageBaseUrl;

  // Utility
  static final state = '$baseUrl/v2/state';
  static final lga = '$baseUrl/v2/lga/'; // pass State Id as params

  // Onboarding
  static final register = '$baseUrl/onboarding/v2/register';
  static final completeOnboard = '$baseUrl/onboarding/completeOnboard';
  static onboardBusinessInfo(String username) =>
      '$baseUrl/business/info?username=$username';

  //Update
  static final forceUpdate = '$baseUrl/param/forceupdate';

  // Profile
  static final addNextOfKin = '$baseUrl/next-of-kin/add';
  static final fetchNextOfKin = '$baseUrl/next-of-kin/view';
  static final viewSecurityQuestion = '$baseUrl/security-question/view';
  static final saveSecurityQuestion = '$baseUrl/security-question/store';
  static final verifySecurityQuestion = '$baseUrl/security-question/verify';

  //Directors
  static final addDirectors = '$baseUrl/directors/add';
  static final updateDirectors = '$baseUrl/directors/update/';
  static final getDirectors = '$baseUrl/directors/list';

  // Business
  static final updateBusiness = '$baseUrl/business/update';
  static final createBusinessRepresentative =
      '$baseUrl/business/representative/create';
  static final fetchBusinessRepresentatives =
      '$baseUrl/business/representative';
  static final fetchBusinessRepresentative =
      '$baseUrl/business/representative/info';

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

  //Inventory
  static final createProductCategory = '$baseUrl/productCategory/create';
  static final updateProductCategory = '$baseUrl/productCategory/update';
  static final searchProductCategory = '$baseUrl/productCategory/search';
  static getProductCategoryByCategoryCode(String categoryCode) =>
      '$baseUrl/productCategory/{$categoryCode}';
  static deleteProductCategoryByCategoryCode(String categoryCode) =>
      '$baseUrl/productCategory/{$categoryCode}';
  static final getProductCategories = '$baseUrl/productCategory/list';

  static final createProduct = '$baseUrl/merchantProduct/create';
  static final updateProduct = '$baseUrl/merchantProduct/update';
  static final searchProduct = '$baseUrl/merchantProduct/search';
  static final filterProduct = '$baseUrl/merchantProduct/filter';
  static final bulkUploadProducts = '$baseUrl/merchantProduct/bulk-upload';
  static getMerchantProductByProductCode(String productCode) =>
      '$baseUrl/merchantProduct/{$productCode}';
  static getMerchantProductByBarcode(String barcode) =>
      '$baseUrl/merchantProduct/{$barcode}';
  static final listMerchantProducts = '$baseUrl/merchantProduct/list';
  static final downloadBulkUploadTemplateFile =
      '$baseUrl/merchantProduct/template/download';

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

  ///Store
  static final getStores = '$baseUrl/store/list';

  static String deleteStore(String storeCode) => '$baseUrl/store/$storeCode';
  static final searchStore = '$baseUrl/store/search';
  static final createStore = '$baseUrl/store/create';
  static final editStore = '$baseUrl/store/update';
  static final getShopOrders = '$baseUrl/orders/filter';
  static final searchStaff = '$baseUrl/staff/search';

  ///MakeA Sale
  static final createOrder = '$baseUrl/orders/create';
  static final updatePaymentStatus = '$baseUrl/orders/payment/status';
  static final getCustomers = '$baseUrl/customer/list';
  static final createCustomer = '$baseUrl/customer/create';
  static final searchCustomer = '$baseUrl/customer/search';

  ///Employee Endpoints
  static final getAllEmployees = '$baseUrl/businessStaff';
  static final registerEmployee = '$baseUrl/businessStaff';
  static final updateEmployee = '$baseUrl/businessStaff/update';
  static String deleteEmployee(String staffCode) =>
      '$baseUrl/businessStaff/staffCode/$staffCode';

  // File Upload Service
  static final uploadFile = '$baseUrl/fileuploadservice/uploadfile/new';
  static final saveDocument = '$baseUrl/document/saveMobileDoc';
  static final getDocuments = '$baseUrl/document/getDocuments';
  static final uploadKYCDocuments = '$baseUrl/document/upload';

  ///KYC Docs
  static final getKycDocuments = '$baseUrl/document/fetchKycDocumentRequired';

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

  // Card payment
  static final cardInitiatePayment = '$baseUrl/card/initiate-payment';
  static final cardInitiatePaymentV2 = '$baseUrl/card/v2/initiate-payment';
  static cardVerify(String reference) =>
      '$baseUrl/card/verify?reference=$reference';
  static final cardVerifyV2 = '$baseUrl/card/v2/verify';
  static final cardList = '$baseUrl/card/list';
  static final cardListV2 = '$baseUrl/card/v2/list';

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

  // Savings
  static final savingsCreate = '$baseUrl/savings/save-plan';
  static final savingsList = '$baseUrl/savings/list';
  static final savingsReturn = '$baseUrl/savings/calculate-return';
  static savingsFunding(int savingId) => '$baseUrl/savings/fund/$savingId';
  static final savingsTotalAmount = '$baseUrl/savings/total-amount';
  static savingsRecentTransaction(int pageNumber, int pageSize) =>
      "$baseUrl/savings/transactions?pageNumber=$pageNumber&pageSize=$pageSize";

  // Fixed deposits
  static final depositInterestRate = '$baseUrl/deposit/v2/interest-rate';
  static final depositCreate = '$baseUrl/deposit/v2/create';
  static final depositInterestType = "$baseUrl/deposit/v2/interest-type";
  static final depositDuration = '$baseUrl/deposit/v2/duration';
  static final depositList = '$baseUrl/deposit/v2';
  static final depositTotalAmount = '$baseUrl/deposit/v2/total-amount';

  ///Card Services
  static final getCardList = '$baseUrl/card-service/card/list';
  static final getCardListV2 = '$baseUrl/card-service/v2/card/list';
  static String getCardDetails(String cardId) =>
      '$baseUrl/card-service/card/$cardId';
  static String getCardDetailsV2(String cardId) =>
      '$baseUrl/card-service/v2/card/$cardId';
  static final requestCard = '$baseUrl/card-service/request';
  static final requestCardV2 = '$baseUrl/card-service/v2/request';
  static final getCardProducts = '$baseUrl/card-service/products';
  static final getCardProductsV2 = '$baseUrl/card-service/v2/products';
  static final changeCardPin = '$baseUrl/card-service/card/change-pin';
  static final changeCardPinV2 = '$baseUrl/card-service/v2/card/change-pin';
  static String blockCard = '$baseUrl/card-service/card/block';
  static String blockCardV2 = '$baseUrl/card-service/v2/card/block';
  static String unBlockCard = '$baseUrl/card-service/card/unblock';
  static String unBlockCardV2 = '$baseUrl/card-service/v2/card/block';
  static String activateCard(String cardId) =>
      '$baseUrl/card-service/card/$cardId/activate';
  static String activateCardV2(String cardId) =>
      '$baseUrl/card-service/v2/card/$cardId/activate';
  //static final setWithdrawalLimit = '$baseUrl/card-service/card/update-limit';
  static String requestChangePinOTP(String cardId) =>
      '$baseUrl/card-service/card/reset-pin-request/$cardId';
  static final verifyChangePinOTP =
      '$baseUrl/card-service/card/verify-reset-pin-otp';
  // static String activateCard(String cardId) =>
  //     '$baseUrl/card-service/card/$cardId/activate';
  static final setCardWithdrawalLimit =
      '$baseUrl/card-service/card/update-limit';
  static final setCardWithdrawalLimitV2 =
      '$baseUrl/card-service/v2/card/update-limit';
  // static String requestChangePinOTP(String cardId) =>
  //     '$baseUrl/card-service/card/reset-pin-request/$cardId';
  // static final verifyChangePinOTP =
  //     '$baseUrl/card-service/card/verify-reset-pin-otp';
  static final resetPin = '$baseUrl/card-service/card/reset-pin';
  static final resetPinV2 = '$baseUrl/card-service/v2/card/reset-pin';
  static final replaceCard = '$baseUrl/card-service/card/replace';

  //Loans
  static final getLoanProducts = '$baseUrl/loanProducts';
  static final computeLoan = '$baseUrl/loanProducts/compute';
  static final loanApplication = '$baseUrl/loanApplications/active';
  static getSingleLoanApplication(String refCode) =>
      '$baseUrl/loanApplications/code/$refCode';
  static final updateLoanApplication = '$baseUrl/loanApplications/update';
  static final updateLoanApplicationV2 = '$baseUrl/loanApplications/update/v2';
  static final getSingleLoanProduct = '$baseUrl/loanProducts/code/';
  static final makeLoanApplication = '$baseUrl/loanApplications';
  static final makeLoanApplicationV2 = '$baseUrl/loanApplications/v2';
  static final getLoanDetails = '$baseUrl/loan/detail';
  static getLoanOfferPDFLink(String refCode) =>
      '$baseUrl/loanProducts/generate/$refCode';
  static final repayLoan = '$baseUrl/loan/make-payment';
  static getLoanProductRequiredDocuments(int loanProduct) =>
      '$baseUrl/document/require/$loanProduct';

  // Referrals
  static fetchReferrals(String code) => "$baseUrl/referral?referralCode=$code";

  //Request POS
  static final requestPOS = '$baseUrl/pos/request';

  // Fixed deposits - OLD
  // static final depositInterestRate = '$baseUrl/deposit/interest-rate';
  // static final depositCreate = '$baseUrl/deposit/create';
  // static depositInterestType(String countryCode) =>
  //     "$baseUrl/deposit/interest-type?countryCode=$countryCode";
  // static final depositDuration = '$baseUrl/deposit/duration';
  // static final depositList = '$baseUrl/deposit';
  // static final depositTotalAmount = '$baseUrl/deposit/total-amount';
}
