import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/target_saving_screen_body.dart';

class IndividualTargetSavingScreen extends ConsumerWidget {
  const IndividualTargetSavingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TargetSavingScreenBody();
  }
}
