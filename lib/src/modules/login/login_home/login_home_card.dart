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
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final config = AppKeysStorage.getConfig();
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 4),
        Center(
          child: Text(
            "${config.loginNuban} | ${state.balanceAcctName}",
            style: AppTextStyles.h7,
          ),
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _balanceText(state, _isBalanceVisible),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isBalanceVisible = !_isBalanceVisible;
                });
              },
              child: Icon(
                _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.rexWhite,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
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

Widget _balanceText(DashboardState state, bool isVisible) {
  switch (state.balanceState) {
    case BalanceStateEnum.initial:
      return Text("\u20A6....", style: AppTextStyles.h9);

    case BalanceStateEnum.cacheFail:
    case BalanceStateEnum.apiFail:
      return Text("\u20A6----", style: AppTextStyles.h9);

    case BalanceStateEnum.cacheCheck:
    case BalanceStateEnum.apiLoading:
      return const SingleShimmer(width: 160, height: 20);

    case BalanceStateEnum.cacheSuccess:
    case BalanceStateEnum.apiSuccess:
      if (!isVisible) {
        return Text("******", style: AppTextStyles.h9);
      }
      final str = state.balanceAvailable.toNairaAmountFormat();
      return Text(str, style: AppTextStyles.h9);
  }
}
