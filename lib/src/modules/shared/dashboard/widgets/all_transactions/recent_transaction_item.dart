import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class RecentTransactionItem extends ConsumerWidget {
  const RecentTransactionItem({
    super.key,
    required this.transData,
    required this.canTap,
  });

  final TransferData transData;
  final bool canTap;

  Color _amountColor(String data) {
    switch (data) {
      case StringAssets.successful:
        return AppColors.rexGreen;

      case StringAssets.pending:
        return AppColors.rexLightBlue2;

      case StringAssets.failedCap:
        return AppColors.red;

      default:
        return AppColors.rexLightBlue2;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusinessAccount = ref.watch(userIsBusinessProvider);
    return InkWell(
      onTap: canTap
          ? () {
              ref.read(inMemoryRecentTransaction.notifier).state = transData;
              if (isBusinessAccount) {
                context.push(
                    "${RouteName.dashboardBusiness}/${RouteName.businessTransactionDetail}");
              } else {
                context.push(
                    "${RouteName.dashboardIndividual}/${RouteName.individualTransactionDetail}");
              }
            }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.ah, horizontal: 16.aw),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.ar),
          color: AppColors.rexWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            transData.crDr == 'C'
                ? SvgPicture.asset(
                    AssetPath.creditIcon,
                    height: 15.ah,
                    width: 15.aw,
                    color: AppColors.rexGreen.withOpacity(0.7),
                  )
                : SvgPicture.asset(
                    AssetPath.debitIcon,
                    height: 15.ah,
                    width: 15.aw,
                    color: AppColors.red4.withOpacity(0.7),
                  ),
            SizedBox(width: 3.aw),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.aw,
                  child: Text(
                    transData.narration.isNotBlank
                        ? transData.narration!.capitalizeEachWordv2()
                        : 'N/A',
                    style: AppTextStyles.bodyRegularSize14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 6.ah),
                Text(
                  transData.transactionDate?.dateReadable() ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transData.crDr.isBlank ? '' : transData.crDr == 'C' ? '+' : '-'} ${transData.amount.toString().toNairaAmountFormat()}',
                  style: AppTextStyles.body2Regular.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _amountColor(transData.transactionStatus ?? ''),
                  ),
                ),
                SizedBox(height: 3.ah),
                Text(
                  transData.transactionStatus ?? 'PENDING',
                  style: AppTextStyles.body1Regular.copyWith(
                    color: AppColors.rexTint500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
