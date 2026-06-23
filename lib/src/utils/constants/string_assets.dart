import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

abstract class Strings {
  static const downloadSetting = 'Please download settings';
  static const downloadSetting2 =
      "Identification failed. Please download settings";
  static const downloadSetting3 = 'Failed to get location. Download settings.';

  static const addMoneyTitle = 'Add Money';
  static const addMoneySubtitle =
      'Easily top up your account with these options';

  static const narration = 'Narration';
  static const confirmTextOnButton = 'Confirm';
  static const sendButtonText = 'Send';
  static const narrationHint = 'Add a narration';

  static const changePassword = 'Change password';
  static const changePasswordSubtext = 'Set a new password';

  static const logoutTitle = 'Logout';
  static const profileTextOnButton = 'Profile';
  static const securityTextOnButton = 'Security';
  static const profileScreenTitle = 'My profile';
  static const profileScreenSubtitle = 'Manage your account information';
  static const emptyString = '';

  static const personalInfoTitle = 'Personal Information';
  static const personalInfoProfileSubtitle = 'Edit your personal information';
  static const personalInfoSubtitle =
      'Add your details to access more features';

  static const emailAddressTitle = 'Email Address';
  static const phoneNumberTitle = 'Phone Number';
  static const dateOfBirthTitle = 'Date of birth';
  static const gender = 'Gender';
  static const addressTitle = 'Address';

  static const moreTitle = 'More';
  static const moreSubtitle = 'Access to more actions on Rex';
  static const profileTitle = 'Profile';
  static const profileSubtitle = 'See your account profile';

  static const changeSecurityQuestion = 'Change Security Question';
  static const changeSecurityQuestionSubText = 'Choose a new security question';

  static const firstNameTitle = 'First Name';
  static const lastNameTitle = 'Last Name';
  static const firstNameHint = 'Enter first name';
  static const lastNameHint = 'Enter last name';
  static const middleNameTitle = 'Middle Name';
  static const middleNameHint = 'Enter middle name';
  static const surnameTitle = 'Surname';
  static const surnameHint = 'Enter surname';
  static const addMiddlename = 'Add middle name';

  static const enterAmount = 'Enter Amount';
  static const transferAmountTitle = 'Transfer amount *';

  static const allTransactionsText = 'All Transactions';
  static const transactionDetailText = 'Transaction Detail';
  static const reportTransactionText = 'Report this transaction';
  static const reportTransactionText2 = 'Report Transaction';

  static const bankTransferTitle = 'Bank Transfer';
  static const bankTransferSubtitle = 'Add money with bank transfer';
  static const cardText = 'Card';
  static const topUpWithSavedCard = 'Top up with saved card or add new card';
  static const topUpWithBankTransfer = 'Top up with bank transfer';

  static const transferMoney = 'Transfer Money';
  static const toRexAccountOrOthers = 'To a Rex account or other banks';

  static const otherBanks = 'Other Banks';
  static const toRex = 'To Rex';
  static const selectBank = 'Select Bank';

  static const accountNumber = 'Account Number';
  static const accountNumberHint = 'Enter Account Number';

  static const invalidAmount = 'Invalid Amount';
  static transactionAmountShouldNotBeLess(String amount) =>
      'Transaction amount should not be less than $amount';

  static const textValidateShort = 'Too short';
  static const textValidateEmpty = 'Cannot be empty';
  static const textValidateName =
      'Name must contain only letters, a hyphen, no spaces';

  static const comingSoonText = 'Coming Soon';
  static const seeAll = 'See all';
  static const recentTransaction = 'Recent Transactions';
  static const recentTransactionError =
      'Oops! Unable to get recent transactions';
  static const noTransactions = 'No Transactions';

  static String getUsernameGreetings(String username) =>
      'Hello, ${username.toTitleCase()}';

  static const featureDisabled = 'This feature is currently disabled.';
  static const activeText = 'ACTIVE';
  static const active = 'Active';
  static const accountNumberCopied = 'Account Number Copied';

  static const usernameText = 'Username';
  static const usernameText2 = 'Enter username';
  static const usernameText3 = 'Enter a unique username';

  static const quickActionsText = 'Quick actions';
  static const transactionsText = 'Transactions';

  static const loginUserPasswordText1 = 'Password';
  static const passwordHint = 'Enter password';

  static const fontFamily = 'Inter';
  static const hiThere = 'Hi There!';

  static const nextTextOnButton = 'Next';

  static const selectDate = 'Select Date';
  static const loadingText = 'Loading...';
  static const declineOfferTitle = 'Decline loan offer';

  static const newDeviceTitle = "Hey User, New device? ";
  static const newDeviceSubtitle =
      "We noticed you're logging in with a new device that has not been verified to your account, want to add this device to your account?";

  static const ok = 'Ok';
  static const dobText = 'Date of birth';
  static const appTitle = 'RexPOS';

  static const filterModalTitle = 'Transaction filter';
  static const filterModalSubtitle = 'Filter all your transactions on Rex';
  static const filterType2 = 'Filter by date';
  static const filterTextOnBtn = 'Apply filter';

  static const endOfList = '* No more transactions *';
  static const filterDate1 = 'Start Date';
  static const filterDate2 = 'End Date';
  static const filterDate3 = 'Reset Date Filter';

  static const approvedLong = 'approved or completed successfully';
  static const approvedShort = 'Approved';

  static const confirmTsqStatus = "Please wait while we confirm status";
  static const confirmTsqStatus2 = "Status confirmed.";

  static const submitPurchase3 =
      "Please wait while we process your transaction.";
  static const submitPurchase4 = "Process complete";
  static const submitPurchase5 = "Process failed.";
  static const submitPurchase6 = "Processing transaction";
}

const topwiseFile =
    'https://res.cloudinary.com/dpepsmzmw/image/upload/v1761919768/rex_circle_logo.png';

abstract class ErrorString {
  static const validationError = 'Validation Error';
}
