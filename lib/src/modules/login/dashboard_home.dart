import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_provider.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/login/widgets/dashboard_account.dart';
import 'package:rex_app/src/modules/login/widgets/dashboard_home_appbar.dart';
import 'package:rex_app/src/modules/login/widgets/dashboard_quick_action_slide.dart';
import 'package:rex_app/src/modules/login/widgets/dashboard_transaction_slide.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/page_view_text_button.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class DashboardHome extends ConsumerStatefulWidget {
  const DashboardHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends ConsumerState<DashboardHome> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(dashboardHomePageViewIndexProvider);
      ref.read(posCardPurchaseProvider.notifier).clearState();
      ref.read(dashboardProvider.notifier).fetchBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(dashboardHomePageViewIndexProvider);

    return Scaffold(
      appBar: const DashboardHomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(dashboardProvider.notifier).fetchBalance();
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const DashboardAccount(),
            Container(
              height: 50,
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              padding: const EdgeInsets.all(6.0),
              decoration: const BoxDecoration(
                color: AppColors.lightGrey2,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageViewTextButton(
                      textOnButton: Strings.quickActionsText,
                      pageController: pageController,
                      backgroundColor:
                          pageIndex == 0 ? AppColors.rexWhite : null,
                      shape: pageIndex == 0 ? roundRectBorder : null,
                      onPressed: () {
                        pageController.previousPage(
                          duration: duration300ms,
                          curve: easeInCurve,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: PageViewTextButton(
                      textOnButton: Strings.transactionsText,
                      pageController: pageController,
                      backgroundColor:
                          pageIndex == 1 ? AppColors.rexWhite : null,
                      shape: pageIndex == 1 ? roundRectBorder : null,
                      onPressed: () {
                        pageController.nextPage(
                          duration: duration300ms,
                          curve: easeInCurve,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.ah),
            SizedBox(
              width: double.infinity,
              height: pageIndex == 0 ? 250.ah : 450.ah,
              child: PageView(
                controller: pageController,
                onPageChanged: (int value) {
                  ref.read(dashboardHomePageViewIndexProvider.notifier).state =
                      value;
                },
                children: const [
                  DashboardQuickActionSlide(),
                  DashboardTransactionSlide(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
