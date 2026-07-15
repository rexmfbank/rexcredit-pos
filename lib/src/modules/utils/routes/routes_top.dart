import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/home/home_screen.dart';
import 'package:rex_app/src/modules/login/dashboard_screen.dart';
import 'package:rex_app/src/modules/login/login_screen.dart';
import 'package:rex_app/src/modules/purchase/ui/quick_purchase_option_screen.dart';
import 'package:rex_app/src/modules/purchase/ui/quick_purchase_screen.dart';
import 'package:rex_app/src/modules/quick_transaction/ui/quick_transactions_detail_screen.dart';
import 'package:rex_app/src/modules/quick_transaction/ui/quick_transactions_screen.dart';
import 'package:rex_app/src/modules/quick_transaction/ui/transaction_create_dispute_screen.dart';
import 'package:rex_app/src/modules/quick_transaction/ui/transaction_fetch_dispute_screen2.dart';
import 'package:rex_app/src/modules/quick_transfer/nfc_reader_screen.dart';
import 'package:rex_app/src/modules/quick_transfer/quick_transfer_screen.dart';
import 'package:rex_app/src/modules/quick_transfer/select_pay_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/eod_outside_filter_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/eod_outside_screen.dart';
import 'package:rex_app/src/modules/splash/splash_screen.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/routes/routes_dashboard.dart';

final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _personalShellNavKey =
    GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> _businessShellNavkey =
//     GlobalKey<NavigatorState>();

/// use parentNavKey when a child route is a Shell Route
// final GlobalKey<NavigatorState> _parentNavKey = GlobalKey<NavigatorState>();

final GoRouter rexGoRouter = GoRouter(
  navigatorKey: rootNavKey,
  initialLocation: Routes.splash,
  routes: topRoutes,
  debugLogDiagnostics: true,
);

List<RouteBase> topRoutes = [
  GoRoute(
    path: Routes.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: Routes.homeScreen,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: Routes.quickTransferScreen,
    builder: (context, state) => const QuickTransferScreen(),
  ),
  GoRoute(
    path: Routes.quickPurchaseScreen,
    builder: (context, state) => const QuickPurchaseScreen(),
  ),
  GoRoute(
    path: Routes.quickPurchaseOption,
    builder: (context, state) => const QuickPurchaseOptionScreen(),
  ),
  GoRoute(
    path: Routes.quickTransactions,
    builder: (context, state) => const QuickTransactionsScreen(),
  ),
  GoRoute(
    path: Routes.quickTransactionDetail,
    builder:
        (context, state) => QuickTransactionsDetailScreen(
          data: state.extra as PosTransactionsResponseData?,
        ),
  ),
  GoRoute(
    path: Routes.eodOutsideScreen,
    builder: (context, state) => const EODOutsideScreen(),
  ),
  GoRoute(
    path: Routes.eodFilterScreen,
    builder: (context, state) => const EODOutsideFilterScreen(),
  ),
  GoRoute(
    path: Routes.createDispute,
    builder: (context, state) => const TransactionCreateDisputeScreen(),
  ),
  GoRoute(
    path: Routes.fetchDispute,
    builder: (context, state) => const TransactionFetchDisputeScreen2(),
  ),
  GoRoute(
    path: Routes.selectPayScreen,
    builder: (context, state) => const SelectPayScreen(),
  ),
  GoRoute(
    path: Routes.nfcReaderScreen,
    builder: (context, state) => const NfcReaderScreen(),
  ),
  GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),
  dashboardShellRoute,
];

final dashboardShellRoute = ShellRoute(
  navigatorKey: _personalShellNavKey,
  builder: (context, state, child) => DashboardScreen(child: child),
  routes: <RouteBase>[dashboardHomeRoutes, dashboardMoreRoutes],
);
