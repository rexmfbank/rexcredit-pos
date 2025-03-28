// ignore_for_file: constant_identifier_names

abstract class ErrorCode {
  static const SUCCESS_STATUS = "SUCCESS";
  static const FAIL_STATUS = "FAILED";
  static const PENDING_STATUS = "PENDING";
  static const PROCESSING_STATUS = "PROCESSING";
  static const COMPLETED_STATUS = "COMPLETED";
  static const USER_LOCKED = "USER_LOCKED";
  static const ACTION_NOT_ALLOWED = "ACTION_NOT_ALLOWED";

  static const ISO_SUCCESS = "00";
  static const SUCCESS = "000";

  static const TRANSACTION_PENDING = "PP";
  static const ERROR = "EE1";

  static const SYSTEM_ERROR = "E06";

  static const PENDING = "001";
  static const FAILED = "002";

  static const NO_RECORD_FOUND = "E20";
  static const NOT_FOUND = "404";
  static const BAD_REQUEST = "403";
  static const JWT_TOKEN_EXPIRED = "E21";

  static const INVALID_CLIENT_ID_OR_SECRET = "E22";

  static const INVALID_IP_ADDRESS = "E43";
  static const API_KEY_NOT_FOUND = "E44";
  static const WRONG_PIN_FORMAT = "E45";
  static const INVALID_CURRENT_PIN = "E46";
  static const NAME_LOOKUP_FAIL = "E47";
  static const WRONG_DEVICE_ID = "E48";

  static const CARD_PRODUCT_NOT_FOUND = "Card product not found";
  static const CARD_PRODUCT_EXIST = "Card product already exist";
  static const CARD_SCHEME_INVALID = "Invalid card scheme";
  static const CARD_TYPE_INVALID = "Invalid card type";
  static const CARD_STATUS_INVALID = "Invalid card status";

  static const INVALID_EMAIL = "EC001";
  static const PERMISSION_DENIED = "EC002";
  static const INVALID_SOURCE_CODE = "EC003";
  static const INVALID_JWT_TOKEN = "EC004";

  static const USERNAME_EXIST = "EC005";
  static const LOGIN_FAILED = "LOGIN_FAILED";
  static const USER_NOT_AUTHORIZED = "USER_NOT_AUTHORIZED";
  static const USER_OTP_NOT_ENTERED = "USER_OTP_NOT_ENTERED";
  static const ADD_OR_REMOVE_ROLE_NOT_ALLOWED =
      "ADD_OR_REMOVE_ROLE_NOT_ALLOWED";
  static const ENTITY_CODE_DISABLE = "ENTITY_CODE_DISABLE";

  static const REQUEST_AWAITING_AUTHORIZATION = "E23";

  static const STORE_EXIST = "S01";
  static const STORE_NOT_FOUND = "S02";

  static const MASTERPRODUCT_EXIST = "M01";
  static const MASTERPRODUCT_NOT_FOUND = "M02";

  static const PRODUCTCATEGORY_EXIST = "C01";
  static const PRODUCTCATEGORY_NOT_FOUND = "C02";

  static const PASSWORD_REPEAT_NOT_ALLOWED = "E49";
  static const MERCHANTPRODUCT_EXIST = "P01";
  static const MERCHANTPRODUCT_NOT_FOUND = "P02";

  static const SEARCH_TERM_LENGTH = "SEARCH.TERM.LENGTH";

  static const SALEORDERS_EXIST = "SALE.ORDERS.EXIST";
  static const SALEORDERS_DUPLICATE = "SALE.ORDERS.DUPLICATE";
  static const SALEORDERS_NOT_FOUND = "SALE.ORDERS.NOT_FOUND";
  static const SALEORDERS_ITEMS_REQUIRED = "SALE.ORDERS.ITEMS.REQUIRED";
  static const SALEORDERS_SUBTOTAL_VALID = "SALE.ORDERS.SUBTOTAL.VALID";
  static const SALEORDERS_QUANTITY_VALID = "SALE.ORDERS.QUANTITY.VALID";
  static const SALEORDERS_STOCK_UNAVAILABLE = "SALE.ORDERS.STOCK.UNAVAILABLE";
  static const SALEORDERS_ITEM_PRODUCT_CODE_REQUIRED =
      "SALE.ORDERS.ITEM.PRODUCT_CODE.REQUIRED";
  static const SALEORDERS_ITEM_AMOUNT_REQUIRED =
      "SALE.ORDERS.ITEM.AMOUNT.REQUIRED";
  static const SALEORDERS_ITEM_AMOUNT_LESS = "SALE.ORDERS.ITEM.AMOUNT.LESS";
  static const SALEORDERS_ITEM_DISCOUNT_REQUIRED =
      "SALE.ORDERS.ITEM.DISCOUNT.REQUIRED";
  static const SALEORDERS_ITEM_TAX_REQUIRED = "SALE.ORDERS.ITEM.TAX.REQUIRED";
  static const SALEORDERS_PAYMENT_STATUS_VALID =
      "SALE.ORDERS.PAYMENT.STATUS.VALID";
  static const SALEORDERS_CANCELLED_ALREADY = "SALE.ORDERS.CANCELLED.ALREADY";
  static const SALEORDERS_CANNOT_CANCELLED = "SALE.ORDERS.CANNOT.CANCELLED";

  static const INVALID_DATE_OF_BIRTH = "E09";
  static const EMPTY_COUNTRY_CODE = "E10";
  static const INVALID_MOBILE_NO = "E11";
  static const USERNAME_ALREADY_EXIST = "E12";
  static const MOBILE_NO_ALREADY_EXIST = "E13";
  static const EMAIL_ALREADY_EXIST = "E14";
  static const BVN_VALIDATION_ERROR = "E15";
  static const SUCCESS_MESSAGE = "SUCCESS_MESSAGE";

  /// ERROR CODES THAT WILL BE ADDED TO LOGIN PAYLOAD
  // Please complete second onboarding stage
  static const COMPLETE_2ND_ONBOARDING = 'EB1';
  // OTP verification is pending
  static const COMPLETE_OTP_VERIFICATION = 'EB2';
  // Transaction PIN to be setup
  static const COMPLETE_TRANSACTION_PIN = 'EB3';
  // User must change PIN
  static const COMPLETE_CHANGE_PIN = 'EB4';
  // User has a new device or is reinstalling the app
  static const INVALID_DEVICE = "E92";
  // Business user needs too complete business information
  static const COMPLETE_BUSINESS_INFO = 'BB01';
  // Business user needs to upload required documents
  static const COMPLETE_BUSINESS_DOCS = 'BB02';
  // Business user need to fill directors details, if it's a LLC
  static const COMPLETE_BUSINESS_DIRECTORS = 'BB03';
}
