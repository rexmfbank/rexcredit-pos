import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/fixed_deposit_summary_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessFixedDepositSummaryScreen extends ConsumerWidget {
  const BusinessFixedDepositSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.regularSavingsAppBarTitle,
        subtitle: StringAssets.savingsPlanSubtitle,
      ),
      body: FixedDepositSummaryScreenBody(),
    );
  }
}
