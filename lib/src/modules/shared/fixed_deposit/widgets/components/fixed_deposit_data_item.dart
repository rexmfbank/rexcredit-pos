import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/deposit_providers.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class FixedDepositDataItem extends ConsumerWidget {
  const FixedDepositDataItem({
    super.key,
    required this.depositData,
  });

  final DepositData depositData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusiness = ref.watch(userIsBusinessProvider);
    //
    return GestureDetector(
      onTap: () {
        ref.read(inMemoryFixedDepositData.notifier).state = depositData;
        if (isBusiness) {
          context.push(
              "${RouteName.dashboardSaveBusiness}/${RouteName.bizFixedDepositDetail}");
        } else {
          context.push(
              "${RouteName.dashboardSave}/${RouteName.individualFixedDepositDetail}");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.rexWhite,
        ),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   getImageAssetPath(),
            //   width: 32,
            //   height: 32,
            // ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        depositData.planName ?? 'N/A',
                        style: AppTextStyles.bodyRegularSize14,
                      ),
                      Text(
                        depositData.amount?.formatCurrencyString() ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.rexPurpleDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        depositData.status ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.rexTint500,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        "${depositData.maturityDate?.dateReadable()}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
