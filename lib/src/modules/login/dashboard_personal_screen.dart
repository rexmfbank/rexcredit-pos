import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/widgets/dadhboard_bottom_nav.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

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
    final name = AppKeysStorage.getConfig().loginFirstname;
    //
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          // ref.watch(userAcctBalanceProvider).isLoading
          //     ? Positioned(
          //       top: AppConstants.deviceHeight / 3,
          //       left: AppConstants.deviceWidth / 2.2,
          //       child: Container(
          //         height: 34.ah,
          //         width: 34.aw,
          //         padding: EdgeInsets.all(8.ar),
          //         alignment: Alignment.center,
          //         decoration: const BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: AppColors.rexWhite,
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black,
          //               blurRadius: 10.0,
          //               spreadRadius: 1.0,
          //             ),
          //           ],
          //         ),
          //         child: const CircularProgressIndicator(
          //           color: AppColors.rexPurpleLight,
          //         ),
          //       ),
          //     )
          //     : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: DashboardBottomNavBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap:
            (int index) =>
                _onItemTapped(index: index, context: context, userName: name),
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
}
