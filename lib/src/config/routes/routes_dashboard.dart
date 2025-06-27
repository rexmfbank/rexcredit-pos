import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/routes/routes_top.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_add_card_webview.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_add_money_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_bank_transfer_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_topup_amount_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/business_add_card_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/business_loan_offer_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/business_loan_repayment.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/dashboard_business.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/screens/dashboard_spend_business.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/transactions/business_all_transactions_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/transactions/business_transaction_detail_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/transactions/business_transaction_dispute_screen.dart';
import 'package:rex_app/src/modules/business/more/bank_statement/business_request_statement_screen.dart';
import 'package:rex_app/src/modules/business/more/faq/business_faq_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_kyc_documents.dart';
import 'package:rex_app/src/modules/business/more/profile/business_profile_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_profile_setup_withdrawal_limit.dart';
import 'package:rex_app/src/modules/business/more/profile/business_security_question_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_setup_biometric_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/enter_transaction_pin_security_question_screen.dart';
import 'package:rex_app/src/modules/business/more/referral/business_referral_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/audit_log_detail_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_delivery_confirm_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_delivery_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_spend_limit_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_track_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/dashboard_business_more.dart';
import 'package:rex_app/src/modules/business/more/screens/more_audit_logs_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/virtual_card_application_screen.dart';
import 'package:rex_app/src/modules/business/more/support/business_chat_screen.dart';
import 'package:rex_app/src/modules/business/more/terms_condition_and_privacy/terms_and_conditons_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_add_user_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_create_role_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_user_management_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_view_users_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_add_card_webview.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_add_money_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_bank_transfer_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_saved_cards_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_topup_amount_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/dashboard_individual.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transactions/individual_all_transactions_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transactions/individual_transaction_detail_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transactions/individual_transaction_dispute_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transfer/transfers_page.dart';
import 'package:rex_app/src/modules/individual/more/bank_statement/individual_request_statement_screen.dart';
import 'package:rex_app/src/modules/individual/more/faqs/ui/screens/faq_screen.dart';
import 'package:rex_app/src/modules/individual/more/privacy_and_terms/legals_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/change_password_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/edit_residential_address_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/enter_old_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/enter_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/new_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/next_of_kin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/personal_info_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/personal_profile_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/profile_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/reset_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/security_question_screen.dart';
import 'package:rex_app/src/modules/individual/more/support/ui/screens/customer_support_screen.dart';
import 'package:rex_app/src/modules/individual/more/support/ui/screens/individual_chat_screen.dart';
import 'package:rex_app/src/modules/individual/more/support/ui/screens/individual_disputes_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/add_document_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/add_documents_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/additional_documents_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/change_password_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/confirm_new_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/dashboard_more.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/enter_bvn_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/enter_new_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/individual_referral_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/new_pin_changed_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/next_of_kin_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/security_question_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/update_account/update_account_screen.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_amount_screen.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_pin_screen.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_screen.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_status_screen.dart';
import 'package:rex_app/src/modules/revamp/reprinting/ui/print_eod_screen.dart';
import 'package:rex_app/src/modules/revamp/reprinting/ui/reprint_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/dashboard_individual_select_saving_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_airtime/screens/airtime_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_airtime/screens/bill_payment_airtime_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_cable/screens/bill_payment_cable_tv_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_cable/screens/bill_payment_cable_tv_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/screens/bill_payment_data_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/screens/bill_payment_data_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_education/screens/bill_payment_education_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_education/screens/bill_payment_education_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/screens/bill_payment_electricity_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/screens/electricity_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/screens/bank_uptime_screen.dart';
import 'package:rex_app/src/modules/shared/spend/widgets/dashboard_spend.dart';

final dashboardHomeRoutes = GoRoute(
  path: Routes.dashboardIndividual,
  builder: (context, state) => const DashboardIndividual(),
  routes: <RouteBase>[
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.transferMoney,
    //   builder: (context, state) => const DashboardHomeTransferScreen(),
    // ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.transferTabPage,
      builder: (context, state) => const TransfersPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.bankUptime,
      builder: (context, state) => const BankUptimeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardAddMoney,
      builder: (context, state) => const DashboardAddMoneyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardSavedCards,
      builder: (context, state) => const DashboardSavedCardsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardTopUpAmount,
      builder: (context, state) => const DashboardTopUpAmountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardAddCardWebview,
      builder: (context, state) => const DashboardAddCardWebView(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBankTransfer,
      builder: (context, state) => const DashboardBankTransferScreen(),
    ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.transferReceipt,
    //   builder: (context, state) =>  TransferReceiptScreen(),
    // ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.individualAllTransactions,
      builder: (context, state) => const IndividualAllTransactionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.individualTransactionDetail,
      builder: (context, state) => const IndividualTransactionDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.individualTransactionDispute,
      builder: (context, state) => const IndividualTransactionDisputeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.purchaseScreen,
      builder: (context, state) => const PurchaseScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.purchaseAmount,
      builder: (context, state) => const PurchaseAmountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.purchasePin,
      builder: (context, state) => const PurchasePinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.purchaseStatus,
      builder: (context, state) => const PurchaseStatusScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.reprintScreen,
      builder: (context, state) => const ReprintScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.printEOD,
      builder: (context, state) => const PrintEodScreen(),
    ),
  ],
);

final dashboardHomeBusinessRoutes = GoRoute(
  path: Routes.dashboardBusiness,
  builder: (context, state) => const DashboardBusiness(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBusinessAddMoney,
      builder: (context, state) => const DashboardBusinessAddMoneyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBusinessSavedCards,
      builder: (context, state) => const DashboardSavedCardsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBusinessTopupAmount,
      builder: (context, state) => const DashboardBusinessTopupAmountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBusinessAddCardWebview,
      builder: (context, state) => const DashboardBusinessAddCardWebview(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBusinessBankTransfer,
      builder: (context, state) => const DashboardBusinessBankTransferScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessLoanOffer,
      builder: (context, state) => const BusinessLoanOfferScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessLoanRepayment,
      builder: (context, state) => const BusinessLoanRepayment(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessAddCard,
      builder: (context, state) => const BusinessAddCardScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessAllTransactions,
      builder: (context, state) => const BusinessAllTransactionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessTransactionDetail,
      builder: (context, state) => const BusinessTransactionDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessTransactionDispute,
      builder: (context, state) => const BusinessTransactionDisputeScreen(),
    ),
  ],
);

final dashboardSpendRoutes = GoRoute(
  path: Routes.dashboardSpend,
  builder: (context, state) => const DashboardSpend(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billAirtime,
      builder: (context, state) => const BillPaymentAirtimeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billData,
      builder: (context, state) => const BillPaymentDataScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billCableTv,
      builder: (context, state) => const BillPaymentCableTvScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billElectricity,
      builder: (context, state) => const BillPaymentElectricityScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billEducation,
      builder: (context, state) => const BillPaymentEducationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billDataConfirm,
      builder: (context, state) => const BillPaymentDataConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billCableTvConfirm,
      builder: (context, state) => const BillPaymentCableTvConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billElectricityConfirm,
      builder: (context, state) => const ElectricityConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billEducationConfirm,
      builder: (context, state) => const BillPaymentEducationConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.billAirtimeConfirm,
      builder: (context, state) => const AirtimeConfirmScreen(),
    ),
  ],
);

final dashboardMoreRoutes = GoRoute(
  path: Routes.dashboardMore,
  builder: (context, state) => const DashboardMore(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.updateAccount,
      builder: (context, state) => const UpdateAccountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.editResidentialAddress,
      builder: (context, state) => const EditResidentialAddressScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.enterBvn,
      builder: (context, state) => const EnterBvnScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.additionalDocuments,
      builder: (context, state) => const AdditionalDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.addDocument,
      builder: (context, state) => const AddDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.addDocumentConfirm,
      builder: (context, state) => const AddDocumentsConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.nextOfKin,
      builder: (context, state) => const NextOfKinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.nextOfKinConfirmed,
      builder: (context, state) => const NextOfKinConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.securityQuestion,
      builder: (context, state) => const SecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.securityQuestionConfirm,
      builder: (context, state) => const SecurityQuestionConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.changepassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.changePasswordConfirm,
      builder: (context, state) => const ChangePasswordConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.enterOldPin,
      builder: (context, state) => const EnterOldPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.enterNewPin,
      builder: (context, state) => const EnterNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.confirmNewPin,
      builder: (context, state) => const ConfirmNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.newPinChange,
      builder: (context, state) => const NewPinChangedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.initiateResetPin,
      builder: (context, state) => const ResetTransactionPinOtpScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.resetTransactionPin,
      builder: (context, state) => const NewTransactionPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.personalInfo,
      builder: (context, state) => const PersonalInfoScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.personalProfile,
      builder: (context, state) => const PersonalProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.support,
      builder: (context, state) => const CustomerSupportScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.legal,
      builder: (context, state) => const LegalsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.faq,
      builder: (context, state) => const FAQScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.securityQuestionPin,
      builder: (context, state) => const EnterTransactionPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.setupBiometric,
      builder: (context, state) => const BusinessSetupBiometricScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.withdrawalLimit,
      builder: (context, state) => BusinessSetupWithdrawalLimitScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.individualReferral,
      builder: (context, state) => const IndividualReferralScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.individualDisputes,
      builder: (context, state) => const IndividualDisputesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.indRequestStatement,
      builder: (context, state) => const IndividualRequestStatementScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.indChatScreen,
      builder: (context, state) => const IndividualChatScreen(),
    ),
  ],
);

final dashboardMoreBusinessRoutes = GoRoute(
  path: Routes.dashboardMoreBusiness,
  builder: (context, state) => const DashboardBusinessMore(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.updateAccount,
      builder: (context, state) => const UpdateAccountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessProfile,
      builder: (context, state) => const BusinessProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.enterBvn,
      builder: (context, state) => const EnterBvnScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.addDocument,
      builder: (context, state) => const AddDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.addDocumentConfirm,
      builder: (context, state) => const AddDocumentsConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.nextOfKin,
      builder: (context, state) => const NextOfKinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.nextOfKinConfirmed,
      builder: (context, state) => const NextOfKinConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.securityQuestion,
      builder: (context, state) => const SecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.securityQuestionConfirm,
      builder: (context, state) => const SecurityQuestionConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.changepassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.initiateResetPin,
      builder: (context, state) => const ResetTransactionPinOtpScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.changePasswordConfirm,
      builder: (context, state) => const ChangePasswordConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.editResidentialAddress,
      builder: (context, state) => const EditResidentialAddressScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.enterOldPin,
      builder: (context, state) => const EnterOldPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.enterNewPin,
      builder: (context, state) => const EnterNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.confirmNewPin,
      builder: (context, state) => const ConfirmNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.newPinChange,
      builder: (context, state) => const NewPinChangedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.personalInfo,
      builder: (context, state) => const PersonalInfoScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.support,
      builder: (context, state) => const CustomerSupportScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.auditLogs,
      builder: (context, state) => const AuditLogsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.auditLogDetail,
      builder: (context, state) => const AuditLogDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.cardsDelivery,
      builder: (context, state) => const CardsDeliveryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.cardsDeliveryConfirm,
      builder: (context, state) => const CardsDeliveryConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.cardsSpendLimit,
      builder: (context, state) => const CardsSpendLimitScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.cardsTracking,
      builder: (context, state) => const CardsTrackScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.virtualCardApply,
      builder: (context, state) => const VirtualCardApplicationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.referral,
      builder: (context, state) => const BusinessReferralScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.termsAndConditions,
      builder: (context, state) => const BusinessTermsAndConditionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.buisnessFaq,
      builder: (context, state) => const BusinessFAQScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessKycDocuments,
      builder: (context, state) => const BusinessKycDocuments(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.setupBiometric,
      builder: (context, state) => const BusinessSetupBiometricScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessSecurityQuestionPin,
      builder: (context, state) =>
          const EnterTransactionPinSecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessSecurityQuestion,
      builder: (context, state) => const BusinessSecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.withdrawalLimit,
      builder: (context, state) => BusinessSetupWithdrawalLimitScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessUserManagement,
      builder: (context, state) => const BusinessUserManagementScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessCreateRole,
      builder: (context, state) => const BusinessCreateRoleScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessViewUsers,
      builder: (context, state) => const BusinessViewUsersScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.businessAddUser,
      builder: (context, state) => const BusinessAddUserScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.bizRequestStatement,
      builder: (context, state) => const BusinessRequestStatementScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.bizChatScreen,
      builder: (context, state) => const BusinessChatScreen(),
    ),
  ],
);
