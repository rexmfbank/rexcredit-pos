abstract class Routes {
  static const splash = '/';

  static const dashboardHome = '/dashboardHome';
  static const dashboardMore = '/dashboardMore';

  static const homeScreen = '/homeScreen';
  static const quickPurchaseOption = '/quickPurchaseOption';
  static const quickTransferScreen = '/quickTransfer';
  static const quickPurchaseScreen = '/quickPurchase';
  static const quickPurchaseStatus = '/quickPurchaseStatus';
  static const quickTransactions = '/quickTrans';
  static const quickTransactionDetail = '/quickTransDetail';
  static const eodOutsideScreen = '/printeodoutside';
  static const eodFilterScreen = '/eodFilter';
  static const createDispute = '/createDispute';
  static const fetchDispute = '/fetchDispute';
  static const selectPayScreen = '/selectPayScreen';
  static const nfcReaderScreen = '/nfcReaderScreen';

  // sub level routes
  static const notificationPage = '/notificationPage';
  static const dashboardAddMoney = 'dashboardAddMoney';
  static const transferMoney = 'transferMoney';
  static const transferTabPage = 'transferTabPage';
  static const allTransactions = 'indAllTransactions';
  static const dashboardTopUpAmount = 'dashboardTopUpAmount';
  static const dashboardBankTransfer = 'dashboardBankTransfer';
  static const transactionDetail = 'indTranDetail';

  static const reprintScreen = "reprintscreen";
  static const eodInsideScreen = "printeod";
  static const eodInsideFilterScreen = "printeodfilter";
  static const purchaseScreen = "purchase";
  static const purchaseAmount = "purchaseAmount";
  static const purchasePin = "purchasePin";
  static const securityQuestionPin = 'securityQuestionPin';
  static const securityQuestionChange = 'securityQuestionChange';
  static const personalProfile = 'personalProfile';

  // Dashboard More
  static const updateAccount = 'updateAccount';
  static const profile = 'profile';
  static const enterBvn = 'enterBvn';
  static const securityQuestion = 'securityQuestion';
  static const securityQuestionConfirm = 'securityQuestionConfirm';
  static const personalInfo = 'personalInfo';

  // Login and in-app routes
  static const login = '/login';
  static const loginHome = '/loginHome';
  static const loginPurchase = '/loginPurchase';
  static const loginReceipt = '/loginReceipt';
  static const loginSettings = '/loginSettings';
}
