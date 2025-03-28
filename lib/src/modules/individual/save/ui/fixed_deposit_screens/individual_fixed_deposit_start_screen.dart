import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/fixed_deposit_start_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class IndividualFixedDepositStartScreen extends ConsumerWidget {
  const IndividualFixedDepositStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: 'Fixed Deposits',
        subtitle: 'Create a fixed deposit plan today',
        step: '',
      ),
      body: FixedDepositStartScreenBody(),
    );
  }
}
