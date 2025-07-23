import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/newProfile/ui/change_password_screen.dart';
import 'package:rex_app/src/modules/revamp/newProfile/ui/reset_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/revamp/newProfile/ui/security_question_change_screen.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/routes_top.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/account_card/dashboard_add_money_screen.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/account_card/dashboard_bank_transfer_screen.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/account_card/dashboard_topup_amount_screen.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/components/dashboard_individual.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/transactions/individual_all_transactions_screen.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/transactions/individual_transaction_detail_screen.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/transactions/individual_transaction_dispute_screen.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/screens/transfers_page.dart';
import 'package:rex_app/src/modules/individual/more/bank_statement/individual_request_statement_screen.dart';
import 'package:rex_app/src/modules/individual/more/faqs/ui/screens/faq_screen.dart';
import 'package:rex_app/src/modules/individual/more/privacy_and_terms/legals_screen.dart';
import 'package:rex_app/src/modules/revamp/newProfile/ui/security_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/revamp/newProfile/ui/new_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/personal_info_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/personal_profile_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/profile_screen.dart';
import 'package:rex_app/src/modules/individual/more/support/ui/screens/individual_disputes_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/additional_documents_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/dashboard_more.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/individual_referral_screen.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_amount_screen.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_option_screen.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_status_screen.dart';
import 'package:rex_app/src/modules/revamp/reprinting/ui/eod_inside_screen.dart';
import 'package:rex_app/src/modules/revamp/reprinting/ui/reprint_screen.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/screens/bank_uptime_screen.dart';

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
      path: Routes.dashboardTopUpAmount,
      builder: (context, state) => const DashboardTopUpAmountScreen(),
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
      builder: (context, state) => const PurchaseOptionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.purchaseAmount,
      builder: (context, state) => const PurchaseAmountScreen(),
    ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: Routes.purchasePin,
    //   builder: (context, state) => const PurchasePinScreen(),
    // ),
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
      path: Routes.eodInsideScreen,
      builder: (context, state) => const EODInsideScreen(),
    ),
  ],
);

final dashboardMoreRoutes = GoRoute(
  path: Routes.dashboardMore,
  builder: (context, state) => const DashboardMore(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.changepassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.additionalDocuments,
      builder: (context, state) => const AdditionalDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.initiateResetPin,
      builder: (context, state) => const ResetTransactionPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.newTransactionPin,
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
      builder: (context, state) => const SecurityTransactionPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.securityQuestionChange,
      builder: (context, state) => const SecurityQuestionChangeScreen(),
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
  ],
);
