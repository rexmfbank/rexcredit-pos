import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/login_home/login_add_money_screen.dart';
import 'package:rex_app/src/modules/login/login_settings/login_settings_screen.dart';
import 'package:rex_app/src/modules/login/login_settings/login_profile_screen.dart';
import 'package:rex_app/src/modules/login/login_transaction/login_transaction_screen.dart';
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
    builder: (context, state) => LoginTransactionScreen(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.loginTransDetail,
    builder:
        (context, state) => LoginTransactionDetailScreen(
          data: state.extra as PosTransactionsResponseData?,
        ),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.loginTransFetch,
    builder:
        (context, state) =>
            LoginTransactionFetchStatus(transRef: state.extra as String? ?? ''),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.loginSettings,
    builder: (context, state) => const LoginSettingsScreen(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.profile,
    builder: (context, state) => const LoginProfileScreen(),
  ),
];
// List<RouteBase> loginPurchaseRoutes = [];
// List<RouteBase> loginReceiptRoutes = [];
// List<RouteBase> loginSettingsRoutes = [
//   GoRoute(
//     parentNavigatorKey: rootNavKey,
//     path: Routes.profile,
//     builder: (context, state) => const SettingsProfileScreen(),
//   ),
// ];

/*final dashboardHomeRoutes = GoRoute(
  path: Routes.dashboardHome,
  routes: <RouteBase>[
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
);*/
