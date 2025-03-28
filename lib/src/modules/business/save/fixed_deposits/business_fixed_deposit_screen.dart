import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/fixed_deposit_screen_body.dart';

class BusinessFixedDepositScreen extends ConsumerWidget {
  const BusinessFixedDepositScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const FixedDepositScreenBody();
  }
}
