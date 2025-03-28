import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/dashboard_topup_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/dashboard_card_layout.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardSavedCardScreenBody extends ConsumerWidget {
  const DashboardSavedCardScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const DashboardCardLayout(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: RexFlatButton(
            onPressed: () => ref
                .watch(dashboardTopUpProvider.notifier)
                .validateTopUp(context),
            buttonTitle: StringAssets.topupTextOnButton,
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
