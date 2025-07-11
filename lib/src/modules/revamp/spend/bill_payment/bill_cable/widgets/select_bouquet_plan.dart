import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_cable/provider/cable_tv_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SelectBouquetPlan extends ConsumerWidget{
  const SelectBouquetPlan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(cableTvProvider);
    var bouquetPlans = state.cableBillers ?? [];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            StringAssets.selectBouquetPlan,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.rexPurpleDark,
            ),
          ),
          const SizedBox(height: 20),
          RexSearchField(
            controller: ref.watch(cableTvProvider).cableSearchController,
            hint: StringAssets.searchByItemName,
            onChanged: (value) => ref.watch(cableTvProvider.notifier).filterCableBillers(value),
            enabledBorderColor: AppColors.rexPurpleLight,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  ref
                      .read(cableTvProvider.notifier)
                      .setSelectedBouquetPlan(context, bouquetPlans[index]);
                  context.pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.aw),
                  child: Text(
                    bouquetPlans[index].productName ?? 'N/A',
                    style: const TextStyle(
                      color: AppColors.rexBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.grey,
                thickness: 0.5,
              ),
              itemCount: bouquetPlans.length,
            ),
          )
        ],
      ),
    );
  }

}