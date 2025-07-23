import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/dashboard_bottom_nav_bar.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardPersonalScreen extends ConsumerStatefulWidget {
  const DashboardPersonalScreen({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardPersonalScreenState();
}

class _DashboardPersonalScreenState
    extends ConsumerState<DashboardPersonalScreen> {
  bool action = false;

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(userFirstNameProvider);
    final emptyNuban = ref.watch(emptyNubanProvider);
    final submitDocs = ref.watch(verifiedAllDocuments);

    //
    return WillPopScope(
      onWillPop: () async => await onWillPopScope(context),
      child: Scaffold(
        body: Stack(
          children: [
            widget.child,
            ref.watch(userAcctBalanceProvider).isLoading
                ? Positioned(
                  top: AppConstants.deviceHeight / 3,
                  left: AppConstants.deviceWidth / 2.2,
                  child: Container(
                    height: 34.ah,
                    width: 34.aw,
                    padding: EdgeInsets.all(8.ar),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.rexWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 1.0, //extend the shadow
                        ),
                      ],
                    ),
                    child: const CircularProgressIndicator(
                      color: AppColors.rexPurpleLight,
                    ),
                  ),
                )
                : const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: DashboardBottomNavBar(
          currentIndex: _calculateSelectedIndex(context),
          onTap:
              (int index) => _onItemTapped(
                index: index,
                context: context,
                hasNuban: emptyNuban,
                hasDocs: submitDocs,
                userName: name,
              ),
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith(Routes.dashboardIndividual)) return 0;
    if (location.startsWith(Routes.dashboardMore)) return 1;
    return 0;
  }

  void _onItemTapped({
    required int index,
    required BuildContext context,
    required bool hasNuban,
    required bool hasDocs,
    required String userName,
  }) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(Routes.dashboardIndividual);
        break;
      case 1:
        GoRouter.of(context).go(Routes.dashboardMore);
        break;
    }
  }

  Future<bool> onWillPopScope(BuildContext context) async {
    if (action == true) {
      return true;
    }
    await showExitModal(
      context: context,
      useDoubleButton: true,
      subtitle: StringAssets.areYouSureExit,
      doubleButtonTitle1: StringAssets.cancel,
      doubleButtonTitle2: StringAssets.yes,
      doubleButton1Tap: () {
        setState(() => action = false);
        context.pop();
      },
      doubleButton2Tap: () {
        setState(() => action = true);
        context.showToast(
          backgroundColor: AppColors.rexPurpleLight,
          message: StringAssets.backPressAgainToExit,
        );
        context.pop();
      },
    ).then((value) => action);
    return false;
  }
}
