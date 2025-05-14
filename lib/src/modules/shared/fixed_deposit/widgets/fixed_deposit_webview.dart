import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FixedDepositWebview extends ConsumerWidget {
  const FixedDepositWebview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createSaving = ref.watch(fixedDepositProvider);
    final isBusiness = ref.watch(userIsBusinessProvider);
    //
    return WebViewWidget(
      controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(
          Uri.parse(ref.read(fixedDepositProvider).cardPaymentUrl),
        )
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {},
            onProgress: (progress) {},
            onUrlChange: (urlChange) {
              if (urlChange.url!.startsWith(createSaving.cardCallbackUrl!) &&
                  urlChange.url!.contains(StringAssets.reference)) {
                showModalActionSuccess(
                  context: context,
                  subtitle: '',
                  title: StringAssets.paymentSuccessful,
                  onPressed: () {
                    ref.read(fixedDepositProvider.notifier).verifyCard();
                    context.pop();
                    showModalAction(
                      context: context,
                      dialogTitle: 'Verifying Card',
                      dialogSubtitle: createSaving.isLoadingCardVerify
                          ? 'Checking'
                          : 'Done',
                      onPressed: () {
                        ref
                            .read(fixedDepositProvider.notifier)
                            .getListOfSavedCards();
                        if (isBusiness) {
                          context.go(
                              "${Routes.dashboardSaveBusiness}/${Routes.bizFixedDepositCard}");
                        } else {
                          context.go(
                              "${Routes.dashboardSave}/${Routes.individualFixedDepositCard}");
                        }
                      },
                    );
                  },
                );
                return;
              }
            },
            onWebResourceError: (error) {},
            onNavigationRequest: (request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..setBackgroundColor(AppColors.rexWhite),
    );
  }
}
