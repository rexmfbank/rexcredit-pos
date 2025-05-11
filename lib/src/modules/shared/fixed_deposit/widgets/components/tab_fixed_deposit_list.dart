import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/deposit_providers.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/fixed_deposit_data_item.dart';

class TabFixedDepositTabList extends ConsumerWidget {
  const TabFixedDepositTabList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingList = ref.watch(fetchFixedDepositList);
    //
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: savingList.when(
        data: (data) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return FixedDepositDataItem(
                depositData: data?[index] ?? const DepositData.empty(),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
