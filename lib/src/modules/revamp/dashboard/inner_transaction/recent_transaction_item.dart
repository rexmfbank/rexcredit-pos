import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

/*class RecentTransactionItem extends ConsumerWidget {
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
    return InkWell(
      onTap:
          canTap
              ? () {
                ref.read(inMemoryRecentTransaction.notifier).state = transData;
                context.push(
                  "${Routes.dashboardIndividual}/${Routes.individualTransactionDetail}",
                );
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 200.aw,
                    child: Text(
                      transData.narration.isNotBlank
                          ? transData.narration!
                              .capitalizeEachWordv2()
                              .truncate(22)
                          : 'N/A',
                      style: AppTextStyles.bodyRegularSize14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 6.ah),
                Text(
                  transData.transactionDate?.dateReadable() ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transData.crDr.isBlank
                      ? ''
                      : transData.crDr == 'C'
                      ? '+'
                      : '-'} ${transData.amount.toString().toNairaAmountFormat()}',
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
}*/

class RecentTransactionItem extends ConsumerWidget {
  const RecentTransactionItem({
    super.key,
    required this.transData,
    required this.canTap,
  });

  final TransferData transData;
  final bool canTap;

  Color _amountColor(String status) => switch (status) {
    Strings.successful => AppColors.rexGreen,
    Strings.pending => AppColors.rexLightBlue2,
    Strings.failedCap => AppColors.red,
    _ => AppColors.rexLightBlue2,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap:
          canTap
              ? () {
                ref.read(inMemoryRecentTransaction.notifier).state = transData;
                context.push(
                  '${Routes.dashboardIndividual}/${Routes.individualTransactionDetail}',
                );
              }
              : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.rexWhite,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              transData.crDr == 'C'
                  ? AssetPath.creditIcon
                  : AssetPath.debitIcon,
              height: 15,
              width: 15,
              color:
                  transData.crDr == 'C'
                      ? AppColors.rexGreen.withValues(alpha: 0.7)
                      : AppColors.red4.withValues(alpha: 0.7),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          (transData.narration?.isNotEmpty ?? false)
                              ? transData.narration!
                                  .capitalizeEachWordv2()
                                  .truncate(40)
                              : 'N/A',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyRegularSize14.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transData.transactionDate?.dateReadable() ?? '',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transData.crDr == 'C' ? '+' : '-'}'
                  '${transData.amount.toString().toNairaAmountFormat()}',
                  style: AppTextStyles.body2Regular.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _amountColor(transData.transactionStatus ?? ''),
                  ),
                ),
                const SizedBox(height: 4),
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
