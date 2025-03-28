import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/fixed_deposit_card_screen_body.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessFixedDepositCardScreen extends ConsumerWidget {
  const BusinessFixedDepositCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(fixedDepositProvider).isLoading,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.savedCardTitle,
        subtitle: StringAssets.savedCardSubtitle,
      ),
      body: const FixedDepositCardScreenBody(),
    );
  }
}
