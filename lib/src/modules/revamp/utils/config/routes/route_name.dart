abstract class Routes {
  // top level routes
  static const splash = '/';
  static const updateAvailable = '/updateAvailable';
  static const welcome = '/welcome';
  static const dashboardIndividual = '/dashboardHome';
  static const dashboardMore = '/dashboardMore';
  static const dashboardSave = '/dashboardSave';
  static const dashboardSavings = '/dashboardSavings';
  static const dashboardSpend = '/dashboardSpend';
  static const dashboardBorrow = '/dashboardBorrow';
  static const dashboardBusiness = '/dashboardHomeBusiness';
  static const dashboardMoreBusiness = '/dashboardBusinessMore';
  static const dashboardSaveBusiness = '/dashboardSaveBusiness';
  static const dashboardSavingsBusiness = '/dashboardSavingsBusiness';
  static const dashboardSpendBusiness = '/dashboardSpendBusiness';
  static const dashboardBorrowBusiness = '/dashboardBorrowBusiness';
  static const login = '/login';
  static const loginExistingUser = '/loginExistingUser';
  static const loginAccountType = '/loginAccountType';
  static const selectCountry = '/selectCountry';
  static const register = '/register';
  static const register2 = '/register2';
  static const registerFaceDetect = '/registerFaceDetect';
  static const registerTerms = '/registerTerms';
  static const otpVerify = '/otpVerify';
  static const accountType = '/accountType';
  static const completeSetup = '/completeSetup';
  static const setTransactionPin = '/setTransactionPin';
  static const confirmTransactionPin = '/confirmTransactionPin';
  static const resetPassword = '/resetPassword';
  static const initiateResetPassword = '/initiateResetPassword';
  static const forgotPasswordConfirmPassword = '/forgotPasswordConfirmPassword';
  static const businessBio = '/businessBio';
  static const bizllcDocs = '/bizllcDoc';
  static const bizllcDirector = '/bizllcDirector';
  static const bizPartnershipDocs = '/bizPartnership';
  static const bizCooperativeDocs = '/bizCooperative';
  static const bizProprietorDocs = '/bizProprietor';
  static const verifyDevice = '/verifyDevice';
  static const chatScreen = '/chatScreen';

  // NEW REVAMP UI
  static const homeScreen = '/homeScreen';
  static const quickTransferScreen = '/quickTransfer';
  static const quickPurchaseScreen = '/quickPurchase';
  static const quickPurchaseStatus = '/quickPurchaseStatus';
  static const quickTransactions = '/quickTrans';
  static const quickTransactionDetail = '/quickTransDetail';
  static const eodOutsideScreen = '/printeodoutside';
  static const eodFilterScreen = '/eodFilter';
  static const createDispute = '/createDispute';
  static const fetchDispute = '/fetchDispute';
  static const changepassword = 'changePassword';
  static const newTransactionPin = 'resetTransactionPin';
  static const initiateResetPin = 'initiateResetPinOtp';
  static const reprintScreen = "reprintscreen";
  static const eodInsideScreen = "printeod";
  static const purchaseScreen = "purchase";
  static const purchaseAmount = "purchaseAmount";
  static const purchasePin = "purchasePin";
  static const purchaseStatus = "purchaseStatus";
  static const securityQuestionPin = 'securityQuestionPin';
  static const securityQuestionChange = 'securityQuestionChange';

  // sub level routes for dashboard individual
  static const notificationPage = '/notificationPage';
  static const accountNumberCreated = 'accountNumberCreated';
  static const accountNumberVerified = 'accountNumberVerified';
  static const dashboardAddMoney = 'dashboardAddMoney';
  static const transferMoney = 'transferMoney';
  static const transferTabPage = 'transferTabPage';
  static const individualAllTransactions = 'indAllTransactions';
  static const businessLoanOffer = 'businessLoanOffer';
  static const businessLoanRepayment = 'businessLoanRepayment';
  static const businessAddCard = 'businessAddCard';
  static const transferReceipt = 'receipt';
  static const dashboardSavedCards = 'dashboardSavedCards';
  static const dashboardTopUpAmount = 'dashboardTopUpAmount';
  static const dashboardAddCardWebview = 'dashboardAddCardWebview';
  static const dashboardBankTransfer = 'dashboardBankTransfer';
  static const individualTransactionDetail = 'indTranDetail';
  static const individualTransactionDispute = 'indTranDispute';
  static const bankUptime = 'bankUptime';

  // sub level routes for dashboard business
  static const dashboardBusinessAddMoney = 'dashboardBusinessAddMoney';
  static const dashboardBusinessSavedCards = 'dashboardBusinessSavedCards';
  static const dashboardBusinessTopupAmount = 'dashboardBusinessTopupAmount';
  static const dashboardBusinessAddCardWebview = 'dashboardBusinessWebview';
  static const dashboardBusinessBankTransfer = 'dashboardBusinessBankTransfer';
  static const businessTransactionDetail = 'bizTranDetail';
  static const businessTransactionDispute = 'bizTranDispute';
  static const businessAllTransactions = 'bizAllTransactions';

  // business quick access
  static const dashboardEmployees = 'dashboardEmployees';
  static const dashboardCashflow = 'dashboardCashflow';

  // Employees
  static const enterEmployeeInformation = 'enterEmployeeInformation';
  static const employeeWorkInformation = 'employeeWorkInformation';
  static const employeeSalaryInformation = 'employeeSalaryInformation';
  static const enterSalaryAmount = 'enterSalaryAmount';
  static const employeeAllowancesList = 'employeeAllowancesList';
  static const employeeDeductionsList = 'employeeDeductionsList';
  static const enterEmployeeAllowances = 'enterEmployeeAllowances';
  static const enterEmployeeDeductions = 'enterEmployeeDeductions';
  static const enterEmployeeBankInformation = 'enterEmployeeBankInformation';
  static const singleEmployee = 'singleEmployee';
  static const employeePersonalDetails = 'employeePersonalDetails';
  static const employeeOnboarding = 'employeeOnboarding';
  static const employeePersonalInfo = 'employeePersonalInfo';

  // Payroll
  static const createPayroll = 'createPayroll';
  static const preparePayroll = 'preparePayroll';
  static const preparePayrollEmployeeLoan = 'preparePayrollEmployeeLoan';
  static const reviewSalaryBreakdown = 'reviewSalaryBreakdown';
  static const employeePayslip = 'employeePayslip';
  static const payrollSummary = 'payrollSummary';

  // Cashflow
  static const cashflowTransactions = 'cashflowTransactions';
  static const cashflowInvoice = 'cashflowInvoice';
  static const cashflowReceipt = 'cashflowReceipt';
  static const cashflowReceiptDetail = 'cashflowReceiptDetail';
  static const cashflowAllInvoice = 'cashflowAllInvoice';
  static const cashflowPreviewInvoice = 'cashflowPreviewInvoice';
  static const cashflowInventory = 'cashflowInventory';
  static const makeASale = 'makeASale';
  static const selectAShop = 'selectAShop';
  static const saleCheckout = 'saleCheckout';
  static const customerList = 'customerList';
  static const shopList = 'shopList';
  static const editList = 'editList';
  static const addList = 'addList';
  static const addInventoryType = 'addInventoryType';
  static const addProducts = 'addProducts';
  static const bulkUpload = 'bulkUpload';
  static const productImages = 'productImages';
  static const paymentLink = 'paymentLink';
  static const cashflowPayments = 'cashflowPayments';
  static const singleInventoryItem = 'singleInventoryItem';
  static const previewPaymentLink = 'previewPaymentLink';
  static const manageInvoice = 'manageInvoice';
  static const addLineItems = 'addLineItems';
  static const inventoryOrders = 'inventoryOrders';

  //Products
  static const productDashboard = 'productDashboard';
  static const productList = 'productList';
  static const addSingleProduct = 'addSingleProduct';
  static const addBulkProducts = 'addBulkProducts';
  static const uploadProductImages = 'uploadProductImages';
  static const categoryList = 'categoryList';
  static const createProductCategory = 'createProductCategory';
  static const categoryDetails = 'categoryDetails';
  static const updateProductCategory = 'updateProductCategory';

  // (Business) Dashboard More
  static const auditLogs = 'auditLogs';
  static const auditLogDetail = 'auditLogDetail';
  static const referral = 'referral';
  static const termsAndConditions = 'termsAndConditions';
  static const faq = 'faq';
  static const buisnessFaq = 'faq';
  static const businessProfile = 'businessProfile';
  static const enterBusinessRepresentative = 'enterBusinessRepresentative';
  static const businessInfo = 'businessInfo';
  static const editBusinessInfo = 'editBusinessInfo';

  static const businessSecurityQuestion = 'businessSecurityQuestion';
  static const withdrawalLimit = 'withdrawalLimit';
  static const cards = 'cards';
  static const requestCards = 'requestCard';
  static const cardRequestSummary = 'cardRequestSummary';
  static const resetCardPin = 'resetCardPin';
  static const activateCardPage = 'activateCardPage';
  static const cardReplacementPage = 'cardReplacementPage';
  static const replacementRequestSummary = 'replacementRequestSummary';
  static const createCardPin = 'createCardPin';
  static const cardTransactionLimit = 'cardTransactionLimit';
  static const requestSent = 'requestSent';
  static const cardsDelivery = 'cardsDelivery';
  static const cardsDeliveryConfirm = 'cardsDeliveryConfirm';
  static const cardsSpendLimit = 'cardsSpendLimit';
  static const cardsTracking = 'cardsTracking';
  static const virtualCardApply = 'virtualCardApply';
  static const addBusinessDirector = 'addBusinessDirector';
  static const businessKycDocuments = 'businessKycDocuments';
  static const uploadDocumentsPage = 'uploadDocumentsPage';
  static const editResidentialAddress = 'editResidentialAddress';
  static const requestPos = 'requestPos';
  static const directorsIdVerification = 'directorsIdVerification';
  static const requestPosUtilityBill = 'requestPosUtilityBill';
  static const requestPosCACDocument = 'requestPosCACDocument';
  static const businessUserManagement = 'bUserManagement';
  static const businessCreateRole = 'bCreateRole';
  static const businessViewUsers = 'bViewUsers';
  static const businessAddUser = 'bAddUser';
  static const addDirectorForm = 'addDirectorForm';
  static const businessSecurityQuestionPin = 'businessSecurityQuestionPin';
  static const bizRequestStatement = 'bizRequestStatement';
  static const bizChatScreen = 'bizChatScreen';

  // (Personal) Dashboard More
  static const updateAccount = 'updateAccount';
  static const profile = 'profile';
  static const enterBvn = 'enterBvn';
  static const additionalDocuments = 'additionalDocuments';
  static const addDocument = 'addDocuments';
  static const addDocumentConfirm = 'addDocumentsConfirm';
  static const nextOfKin = 'nextOfKin';
  static const nextOfKinConfirmed = 'nextOfKinConfirmed';
  static const securityQuestion = 'securityQuestion';
  static const securityQuestionConfirm = 'securityQuestionConfirm';
  static const personalInfo = 'personalInfo';

  static const changePasswordConfirm = 'changePasswordConfirm';
  static const enterOldPin = 'enterOldPin';
  static const enterNewPin = 'enterNewPin';
  static const confirmNewPin = 'confirmNewPin';
  static const newPinChange = 'newPinChange';
  static const support = 'support';
  static const legal = 'legal';
  static const individualReferral = 'individualRef';
  static const individualDisputes = 'individualDisputes';
  static const newDeviceAdded = 'newDeviceAdded';
  static const indRequestStatement = 'indRequestStatement';
  static const indChatScreen = 'indChatScreen';

  // Dashboard spend routes
  static const billAirtime = 'airtime';
  static const billData = 'data';
  static const billCableTv = 'cableTv';
  static const billElectricity = 'electricity';
  static const billEducation = 'education';
  static const billDataConfirm = 'dataConfirm';
  static const billCableTvConfirm = 'cableTvConfirm';
  static const billElectricityConfirm = 'electricityConfirm';
  static const billEducationConfirm = 'educationConfirm';
  static const billAirtimeConfirm = 'airtimeConfirm';

  // (Business) Dashboard borrow routes

  //
  static const businessBorrow = 'businessBorrow';
  static const businessLoanDocumentation = 'businessLoanDocumentation';
  static const businessPersonalDetail = 'businessPersonalDetail';
  static const businessGuarantorDetail = 'businessGuarantorDetail';
  static const businessEmployeeLoanType = 'businessEmployeeLoanType';
  static const businessPubBorrow = 'businessPublicEmployeeBorrow';
  static const businessPubLoanDocScreen =
      'businessPublicEmployeeLoanDocumentation';
  static const businessPubPersonalDetails = 'businessLoanPersonalDetails';
  static const businessPubGuarantorDetails = 'businessLoanGuarantorDetails';
  static const businessEmploymentDetails = 'businessEmploymentProfile';
  static const businessPubConnectBank = 'businessConnectYourBank';
  static const businessPubConnectBankDetails = 'businessConnectYourBankDetails';
  static const businessEmployeeCreateLoan = 'businessEmployeeCreateLoan';
  static const businessEmployeeLoanDocumentation =
      'businessEmployeeLoanDocumentation';
  static const businessListOfAgencies = 'businessListOfAgencies';
  static const businessLoanApplicationPending =
      'businessLoanApplicationPending';
  static const businessLoanActiveDashboard = 'businessLoanActiveDashboard';

  static const personalProfile = 'personalProfile';
}
