import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/deposit_providers.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/fixed_deposit_empty.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/fixed_deposit_non_empty.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class FixedDepositScreenBody extends ConsumerWidget {
  const FixedDepositScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savings = ref.watch(fetchFixedDepositList);

    return Container(
      child: savings.when(
        data: (data) {
          if (data != null && data.isEmpty) {
            return const FixedDepositEmpty();
          }
          return const FixedDepositNonEmpty();
        },
        error: (error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Unable to retrieve information on fixed deposits',
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
