import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_provider.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_pagination_notifier.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/trans_dispute_notifier.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/eod_pagination_notifier.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

/// In-memory flow providers that must not survive an idle logout.
///
/// [loginProvider] is intentionally omitted: the login screen is about to be
/// shown and that notifier owns the passcode controllers.
final inAppSessionProviders = <ProviderOrFamily>[
  posCardPurchaseProvider,
  posPaginationProvider,
  dashboardProvider,
  reprintProvider,
  transDisputeProvider,
  eodPaginationProvider,
];

void invalidateInAppSessionProviders(WidgetRef ref) {
  for (final provider in inAppSessionProviders) {
    ref.invalidate(provider);
  }
}

/// Pops pushed pages and dialogs so a later `go(loginHome)` cannot restore them.
///
/// Capped so a [PopScope] that refuses to pop cannot loop forever.
void popAllInAppRoutes(GoRouter router) {
  const maxPops = 32;
  var pops = 0;
  while (router.canPop() && pops < maxPops) {
    try {
      router.pop();
    } on Object {
      break;
    }
    pops++;
  }
}

/// Clears in-app flow state and the navigation stack, then sends the user to login.
void endInAppSession({
  required WidgetRef ref,
  required GoRouter router,
}) {
  invalidateInAppSessionProviders(ref);
  popAllInAppRoutes(router);
  router.go(Routes.login);
}
