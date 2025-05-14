import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/dashboard_topup_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashboardWebWidget extends ConsumerWidget {
  const DashboardWebWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusinessAccount = ref.watch(userIsBusinessProvider);
    final topUp = ref.watch(dashboardTopUpProvider);

    return WebViewWidget(
      controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(
          Uri.parse(ref.read(dashboardTopUpProvider).cardPaymentUrl),
        )
        ..setBackgroundColor(AppColors.rexWhite)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {},
            onProgress: (progress) {},
            onWebResourceError: (error) {},
            onNavigationRequest: (request) {
              return NavigationDecision.navigate;
            },
            onUrlChange: (urlChange) {
              if (urlChange.url!.startsWith(topUp.cardCallbackUrl!) &&
                  urlChange.url!.contains(StringAssets.reference)) {
                ref.read(dashboardTopUpProvider.notifier).verifyCard();
                showModalAction(
                  context: context,
                  dialogTitle: StringAssets.verifyingCard,
                  dialogSubtitle:
                      topUp.isLoadingCardVerify ? 'Checking' : 'Done',
                  onPressed: () {
                    context.pop();
                    ref
                        .read(dashboardTopUpProvider.notifier)
                        .getListOfSavedCards();
                    if (isBusinessAccount) {
                      context.go(
                          "${Routes.dashboardBusiness}/${Routes.dashboardBusinessSavedCards}");
                    } else {
                      context.go(
                          "${Routes.dashboardIndividual}/${Routes.dashboardSavedCards}");
                    }
                  },
                );
                return;
              }
            },
          ),
        ),
    );
  }
}
