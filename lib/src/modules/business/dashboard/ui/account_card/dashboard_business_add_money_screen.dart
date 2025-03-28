import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/add_money_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardBusinessAddMoneyScreen extends ConsumerWidget {
  const DashboardBusinessAddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        step: '',
        title: StringAssets.addMoneyTitle,
        subtitle: StringAssets.addMoneySubtitle,
        onBackButtonPressed: () {
          context.go(RouteName.dashboardBusiness);
        },
      ),
      body: const AddMoneyScreenBody(),
    );
  }
}
