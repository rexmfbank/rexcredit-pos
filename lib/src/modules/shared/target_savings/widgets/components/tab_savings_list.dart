import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/savings_providers.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/target_saving_data_item.dart';

class TabSavingsList extends ConsumerWidget {
  const TabSavingsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingList = ref.watch(fetchSavingsListProvider);
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
              return TargetSavingDataItem(
                targetSavingsData:
                    data?[index] ?? const FetchTargetSavingsData.empty(),
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
