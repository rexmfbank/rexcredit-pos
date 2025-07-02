import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/add_money_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardAddMoneyScreen extends ConsumerWidget {
  const DashboardAddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.addMoneyTitle,
        subtitle: StringAssets.addMoneySubtitle,
        onBackButtonPressed: () {
          context.go(Routes.dashboardIndividual);
        },
      ),
      body: const AddMoneyScreenBody(),
    );
  }
}
