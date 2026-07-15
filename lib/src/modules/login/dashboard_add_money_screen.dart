import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_list_tile.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class DashboardAddMoneyScreen extends ConsumerWidget {
  const DashboardAddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: Strings.addMoneyTitle,
        subtitle: Strings.addMoneySubtitle,
        onBackButtonPressed: () {
          context.go(Routes.dashboardIndividual);
        },
      ),
      body: const AddMoneyScreenBody(),
    );
  }
}

class AddMoneyScreenBody extends ConsumerWidget {
  const AddMoneyScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        RexListTile(
          leadingWidget: Image.asset(AssetPath.bankIcon),
          title: Strings.bankTransferTitle,
          subtitle: Strings.topUpWithBankTransfer,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              "${Routes.dashboardIndividual}/${Routes.dashboardBankTransfer}",
            );
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.bankCardIcon),
          title: Strings.cardText,
          subtitle: Strings.topUpWithSavedCard,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              '${Routes.dashboardIndividual}/${Routes.dashboardTopUpAmount}',
            );
          },
        ),
      ],
    );
  }
}
