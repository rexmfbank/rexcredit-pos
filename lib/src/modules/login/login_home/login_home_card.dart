import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_provider.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_state.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/container_style_button.dart';
import 'package:rex_app/src/modules/utils/widgets/loading_indicator_overlay.dart';

class LoginHomeCard extends ConsumerStatefulWidget {
  const LoginHomeCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginHomeCardState();
}

class _LoginHomeCardState extends ConsumerState<LoginHomeCard> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final config = AppKeysStorage.getConfig();
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${config.loginNuban} | ${state.balanceAcctName}",
              style: AppTextStyles.h7,
            ),
            SizedBox(width: 4),
            Icon(Icons.copy, color: AppColors.rexWhite),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text("${returnBalanceText2(state)}", style: AppTextStyles.h7),
            returnBalanceText2(state),
            SizedBox(width: 4),
            Icon(Icons.visibility, color: AppColors.rexWhite),
          ],
        ),
        SizedBox(height: 4),
        Text("Book Balance: ${state.balanceLedger}", style: AppTextStyles.h7),
        // Row(children: [Text('Book')]),
        // returnBalanceText2(state),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ContainerStyleButton(
                title: 'Transfer',
                bgColor: AppColors.rexWhite,
                textColor: AppColors.rexPurpleDark3,
                onTap: () {
                  context.push(Routes.loginTransferPath);
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ContainerStyleButton(
                title: 'Add Money',
                bgColor: AppColors.rexWhite,
                textColor: AppColors.rexPurpleDark3,
                onTap: () {
                  context.push(Routes.loginAddMoneyPath);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}

Widget returnBalanceText2(DashboardState state) {
  switch (state.balanceState) {
    case BalanceStateEnum.initial:
      return Text("\u20A6....", style: AppTextStyles.h7);

    case BalanceStateEnum.cacheFail:
    case BalanceStateEnum.apiFail:
      return Text("\u20A6----", style: AppTextStyles.h7);

    case BalanceStateEnum.cacheCheck:
    case BalanceStateEnum.apiLoading:
      return const SingleShimmer(width: 160, height: 20);

    case BalanceStateEnum.cacheSuccess:
    case BalanceStateEnum.apiSuccess:
      final str = state.balanceAvailable.toNairaAmountFormat();
      return Text(str, style: AppTextStyles.h7);
  }
}
