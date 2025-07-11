import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/components/empty_beneficiary_list.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_electricity/provider/electricity_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_electricity/widgets/meter_type_item.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class MeterTypeList extends ConsumerWidget {
  const MeterTypeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppConstants.deviceHeight - 70.ah,
      child: Padding(
        padding: EdgeInsets.all(16.ah),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringAssets.selectMeterType,
              style: TextStyle(
                fontSize: 18.asp,
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleDark,
              ),
            ),
            SizedBox(height: 24.ah),
            RexSearchField(
              controller:
                  ref.watch(electricityProvider).searchMeterTypeController,
              hint: StringAssets.searchForProviders,
              onChanged: (value) => ref
                  .watch(electricityProvider.notifier)
                  .filterMeterType(value),
              hintStyle: AppTextStyles.body2Regular.copyWith(
                color: AppColors.rexTint500,
                fontSize: 13.asp,
              ),
              enabledBorderColor: AppColors.rexPurpleLight,
              borderRadius: 15.ar,
            ),
            Builder(builder: (context) {
              if (ref.watch(electricityProvider).selectedServiceProvider ==
                      null ||
                  ref
                          .watch(electricityProvider)
                          .selectedServiceProvider!
                          .products ==
                      null ||
                  ref
                      .watch(electricityProvider)
                      .selectedServiceProvider!
                      .products!
                      .isEmpty) {
                return const EmptyBeneficiaryList(
                  text: StringAssets.meterListEmpty,
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount:
                      ref.watch(electricityProvider).billerProducts!.length,
                  itemBuilder: (context, index) => MeterTypeItem(
                    product: ref
                        .watch(electricityProvider)
                        .billerProducts![index],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
