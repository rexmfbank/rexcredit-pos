import 'package:rex_app/src/modules/login/dashboard_personal_screen.dart';
import 'package:rex_app/src/modules/login/login_screen.dart';
import 'package:rex_app/src/modules/utils/routes/routes_dashboard.dart';

import 'routes_imports.dart';

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
    path: Routes.quickPurchaseStatus,
    builder: (context, state) => const QuickPurchaseStatusScreen(),
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
  builder: (context, state, child) => DashboardPersonalScreen(child: child),
  routes: <RouteBase>[dashboardHomeRoutes, dashboardMoreRoutes],
);
