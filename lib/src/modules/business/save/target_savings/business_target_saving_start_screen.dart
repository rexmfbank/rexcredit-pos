import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/target_saving_start_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessTargetSavingStartScreen extends ConsumerWidget {
  const BusinessTargetSavingStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.createRegularSavingsTitle,
        subtitle: StringAssets.createSavingsPlanSubtitle,
      ),
      body: TargetSavingStartScreenBody(),
    );
  }
}
