import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/dashboard_home_appbar.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/dashboard_quick_action_slide.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/account_card/dashboard_account.dart';
import 'package:rex_app/src/modules/revamp/dashboard/inner_transaction/dashboard_transaction_slide.dart';
import 'package:rex_app/src/modules/shared/widgets/page_view_text_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardIndividual extends ConsumerStatefulWidget {
  const DashboardIndividual({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardIndividualState();
}

class _DashboardIndividualState extends ConsumerState<DashboardIndividual> {
  final PageController pageController = PageController();

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     ref.invalidate(dashboardHomePageViewIndexProvider);
  //     //ref.read(dashboardProvider.notifier).checkKycPending(context);
  //     ref.read(dashboardProvider.notifier).checkPasswordChange(context);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(dashboardHomePageViewIndexProvider);

    return Scaffold(
      appBar: const DashboardHomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(userAcctBalanceProvider);
          ref.refresh(
            userRecentTransactionProvider(
              const RecentTransactionParam(startDate: '', endDate: ''),
            ),
          );
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
                      textOnButton: StringAssets.quickActionsText,
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
                      textOnButton: StringAssets.transactionsText,
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
