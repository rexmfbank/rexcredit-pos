import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/provider/electricity_provider.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SelectElectricityPlan extends ConsumerWidget{
  const SelectElectricityPlan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(billPaymentProvider);
    var billers = state.electricBillers ?? [];
    return Padding(
      padding: EdgeInsets.all(16.ar),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
           Text(
            StringAssets.selectBiller,
            style: TextStyle(
              fontSize: 18.asp,
              fontWeight: FontWeight.w600,
              color: AppColors.rexPurpleDark,
            ),
          ),
          SizedBox(height: 20.ah),
          RexSearchField(
            controller: ref.watch(billPaymentProvider).electricitySearchController,
            hint: StringAssets.searchByItemName,
            onChanged: (value) => ref.watch(billPaymentProvider.notifier).filterElectricityBillers(value),
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
                      .read(electricityProvider.notifier)
                      .setSelectedServiceProvider(billers[index]);
                  context.pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.ar),
                  child: Row(
                    children: [
                      Container(
                        height: 30.ah,
                        width: 30.aw,
                        padding: EdgeInsets.all(4.ar),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.ar),
                          color: AppColors.rexPurpleLight.withOpacity(0.2),
                        ),
                        child: CachedNetworkImage(
                            imageUrl: billers[index].logoUrl ??
                                'https://picsum.photos/200'),
                      ),
                      SizedBox(width: 10.aw),
                      Text(
                        billers[index].billerName ?? 'N/A',
                        style: const TextStyle(
                            color: AppColors.rexBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.grey,
                thickness: 0.5,
              ),
              itemCount: billers.length,
            ),
          )
        ],
      ),
    );
  }

}
