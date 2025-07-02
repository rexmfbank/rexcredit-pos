import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/provider/data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SelectDataPlan extends ConsumerWidget{
  const SelectDataPlan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(billPaymentDataProvider);
    var dataPlans = state.products ?? [];
    return Padding(
      padding: EdgeInsets.all(16.ar),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringAssets.selectDataPlan,
            style: AppTextStyles.h5,
          ),
          SizedBox(height: 20.ah),
          RexSearchField(
            controller: ref.watch(billPaymentDataProvider).dataSearchController,
            hint: StringAssets.searchByItemName,
            onChanged: (value) => ref.watch(billPaymentDataProvider.notifier).filterData(value),
            enabledBorderColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 24.ah),
          Expanded(
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  ref
                      .read(billPaymentDataProvider.notifier)
                      .setSelectedDataPlan(dataPlans[index]);
                  context.pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.aw),
                  child: Text(
                    '${dataPlans[index].productName ?? 'N/A'} - ${dataPlans[index].productDesc ?? ''}',
                    style: AppTextStyles.body2Regular.copyWith(
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => Divider(
                color: AppColors.grey,
                thickness: 0.5.aw,
              ),
              itemCount: dataPlans.length,
            ),
          )
        ],
      ),
    );
  }

}