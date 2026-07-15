import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/login/dashboard_add_money_screen.dart';
import 'package:rex_app/src/modules/login/dashboard_individual.dart';
import 'package:rex_app/src/modules/more/dashboard_more.dart';
import 'package:rex_app/src/modules/more/personal_profile_screen.dart';
import 'package:rex_app/src/modules/more/profile_screen.dart';
import 'package:rex_app/src/modules/purchase/purchase_amount_screen.dart';
import 'package:rex_app/src/modules/purchase/purchase_option_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/eod_inside_filter_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/eod_inside_screen.dart';
import 'package:rex_app/src/modules/reprint_eod/ui/reprint_screen.dart';
import 'package:rex_app/src/modules/transactions/all_transactions_detail_screen.dart';
import 'package:rex_app/src/modules/transactions/all_transactions_screen.dart';
import 'package:rex_app/src/modules/transfer/dashboard_bank_transfer_screen.dart';
import 'package:rex_app/src/modules/transfer/transfers_page.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';

final dashboardHomeRoutes = GoRoute(
  path: Routes.dashboardIndividual,
  builder: (context, state) => const DashboardIndividual(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.transferTabPage,
      builder: (context, state) => const TransfersPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardAddMoney,
      builder: (context, state) => const DashboardAddMoneyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: Routes.dashboardBankTransfer,
      builder: (context, state) => const DashboardBankTransferScreen(),
    ),
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
      path: Routes.personalProfile,
      builder: (context, state) => const PersonalProfileScreen(),
    ),
  ],
);
