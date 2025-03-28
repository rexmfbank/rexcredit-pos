import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/target_saving_card_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessTargetSavingCardScreen extends ConsumerWidget {
  const BusinessTargetSavingCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(targetSavingProvider).isLoading,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.savedCardTitle,
        subtitle: StringAssets.savedCardSubtitle,
      ),
      body: const TargetSavingCardScreenBody(),
    );
  }
}
