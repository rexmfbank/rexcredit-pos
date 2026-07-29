abstract class Routes {
  static const dashboardHome = '/dashboardHome';

  static const homeScreen = '/homeScreen';
  static const quickPurchaseOption = '/quickPurchaseOption';
  static const quickTransferScreen = '/quickTransfer';
  static const quickPurchaseScreen = '/quickPurchase';
  static const quickPurchaseStatus = '/quickPurchaseStatus';
  static const quickTransactions = '/quickTrans';
  static const quickTransactionDetail = '/quickTransDetail';
  static const quickTransactionFetchStatus = '/quickTransFetchStatus';
  static const eodOutsideScreen = '/printeodoutside';
  static const eodFilterScreen = '/eodFilter';
  static const createDispute = '/createDispute';
  static const fetchDispute = '/fetchDispute';
  static const selectPayScreen = '/selectPayScreen';
  static const nfcReaderScreen = '/nfcReaderScreen';

  // sub level routes
  static const notificationPage = '/notificationPage';
  static const transferMoney = 'transferMoney';
  static const transactionDetail = 'indTranDetail';

  static const reprintScreen = "reprintscreen";
  static const eodInsideScreen = "printeod";
  static const eodInsideFilterScreen = "printeodfilter";
  static const purchaseScreen = "purchase";
  static const purchaseAmount = "purchaseAmount";
  static const purchasePin = "purchasePin";
  static const securityQuestionPin = 'securityQuestionPin';
  static const securityQuestionChange = 'securityQuestionChange';

  // Login and in-app routes
  static const login = '/login';
  static const loginHome = '/loginHome';
  static const loginSettings = 'loginSettings';
  static const loginSettingsPath = '$loginHome/$loginSettings';
  static const loginAddMoney = 'loginAddMoney';
  static const loginAddMoneyPath = '$loginHome/$loginAddMoney';
  static const loginTransfer = 'loginTransfer';
  static const loginTransferPath = '$loginHome/$loginTransfer';
  static const loginTransHistory = 'loginTransHistory';
  static const loginTransHistoryPath = '$loginHome/$loginTransHistory';
  static const loginTransDetail = 'loginTransDetail';
  static const loginTransDetailPath = '$loginHome/$loginTransDetail';
  static const profile = 'profile';
  static const profilePath = '$loginHome/$profile';
}
