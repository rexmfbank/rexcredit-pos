import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/login/login_home/login_add_money_screen.dart';
import 'package:rex_app/src/modules/login/login_home/login_trans_history.dart';
import 'package:rex_app/src/modules/login/login_settings/settings_profile_screen.dart';
import 'package:rex_app/src/modules/purchase/ui/purchase_amount_screen.dart';
import 'package:rex_app/src/modules/purchase/ui/purchase_option_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/eod_inside_filter_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/eod_inside_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/reprint_screen.dart';
import 'package:rex_app/src/modules/transactions/all_transactions_detail_screen.dart';
import 'package:rex_app/src/modules/transactions/all_transactions_screen.dart';
import 'package:rex_app/src/modules/transfer/dashboard_bank_transfer_screen.dart';
import 'package:rex_app/src/modules/transfer/transfer_new/transfer_new_screen.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';

List<RouteBase> loginHomeRoutes = [
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.loginAddMoney,
    builder: (context, state) => const LoginAddMoneyScreen(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.loginTransfer,
    builder: (context, state) => const TransferNewScreen(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.loginTransHistory,
    builder: (context, state) => LoginTransHistory(),
  ),
];
List<RouteBase> loginPurchaseRoutes = [];
List<RouteBase> loginReceiptRoutes = [];
List<RouteBase> loginSettingsRoutes = [
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.profile,
    builder: (context, state) => const SettingsProfileScreen(),
  ),
];

final dashboardHomeRoutes = GoRoute(
  path: Routes.dashboardHome,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBankTransfer,
      builder: (context, state) => const DashboardBankTransferScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.allTransactions,
      builder: (context, state) => const AllTransactionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.transactionDetail,
      builder: (context, state) => const TransactionDetailScreen(),
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
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.eodInsideFilterScreen,
      builder: (context, state) => const EODInsideFilterScreen(),
    ),
  ],
);
