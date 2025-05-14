import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/topup_amount_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardBusinessTopupAmountScreen extends ConsumerWidget {
  const DashboardBusinessTopupAmountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        step: '',
        title: StringAssets.topupScreenTitle,
        subtitle: StringAssets.topupScreenSubtitle,
        onBackButtonPressed: () {
          context.go(
            "${Routes.dashboardBusiness}/${Routes.dashboardBusinessAddMoney}",
          );
        },
      ),
      body: const TopupAmountScreenBody(),
    );
  }
}
