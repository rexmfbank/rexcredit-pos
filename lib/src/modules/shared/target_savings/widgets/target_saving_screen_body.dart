import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/savings_providers.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/target_savings_empty.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/target_savings_non_empty.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TargetSavingScreenBody extends ConsumerWidget {
  const TargetSavingScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savings = ref.watch(fetchSavingsListProvider);

    return Container(
      child: savings.when(
        data: (data) {
          if (data != null && data.isEmpty) {
            return const TargetSavingsEmpty();
          }
          return const TargetSavingsNonEmpty();
        },
        error: (error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringAssets.savingScreenErrorText,
                style: AppTextStyles.bodyRegularSize14,
              )
            ],
          );
        },
        loading: () {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
