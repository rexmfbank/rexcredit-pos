import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_provider.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_state.dart';
import 'package:rex_app/src/modules/utils/widgets/loading_indicator_overlay.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

class AccountBalanceText extends ConsumerWidget {
  const AccountBalanceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: returnBalanceText(state),
      ),
    );
  }
}

Widget returnBalanceText(DashboardState state) {
  switch (state.balanceState) {
    case BalanceStateEnum.initial:
      return Text("\u20A6....", style: AppTextStyles.walletText1);

    case BalanceStateEnum.cacheFail:
    case BalanceStateEnum.apiFail:
      return Text("\u20A6----", style: AppTextStyles.walletText1);

    case BalanceStateEnum.cacheCheck:
    case BalanceStateEnum.apiLoading:
      return const SingleShimmer(width: 160);

    case BalanceStateEnum.cacheSuccess:
    case BalanceStateEnum.apiSuccess:
      final str = state.balanceAvailable.toNairaAmountFormat();
      return Text(str, style: AppTextStyles.walletText1);
  }
}

// child: Text('₦x.x'),
