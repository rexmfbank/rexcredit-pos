import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/savings_providers.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/saving_transaction_item.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class TabSavingsTransaction extends ConsumerWidget {
  const TabSavingsTransaction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tList = ref.watch(
      fetchSavingsTransaction(
        const SavingsTranParam(pageNumber: 1, pageSize: 30),
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: tList.when(
        data: (data) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return SavingTransactionItem(
                transaction:
                    data?[index] ?? const SavingsTransactionData.empty(),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            'Not available',
            style: AppTextStyles.bodyRegularSize14,
          ),
        ),
        loading: () => const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 4.0),
              Text('Loading transactions'),
            ],
          ),
        ),
      ),
    );
  }
}
