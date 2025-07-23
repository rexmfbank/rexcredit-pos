import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/topup_amount_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardTopUpAmountScreen extends ConsumerWidget {
  const DashboardTopUpAmountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.topupScreenTitle,
        subtitle: StringAssets.topupScreenSubtitle,
        onBackButtonPressed: () => context.pop(),
      ),
      body: const TopupAmountScreenBody(),
    );
  }
}
