import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

class RecentTransactionItem extends ConsumerWidget {
  const RecentTransactionItem({
    super.key,
    required this.transData,
    required this.canTap,
  });

  final Transaction transData;
  final bool canTap;

  // Color _amountColor(String status) => switch (status) {
  //   Strings.successful => AppColors.rexGreen,
  //   Strings.pending => AppColors.rexLightBlue2,
  //   Strings.failedCap => AppColors.red,
  //   _ => AppColors.rexLightBlue2,
  // };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap:
          canTap
              ? () {
                ref.read(inMemoryRecentTransaction.notifier).state = transData;
                context.push(
                  '${Routes.dashboardHome}/${Routes.transactionDetail}',
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
              transData.transactionType == 'credit'
                  ? AssetPath.creditIcon
                  : AssetPath.debitIcon,
              height: 15,
              width: 15,
              color:
                  transData.transactionType == 'credit'
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
                          transData.transactionDescription ?? 'narration n/a',
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
                  '${transData.transactionType == 'credit' ? '+' : '-'}'
                  '${transData.transactionAmount?.toNairaAmountFormat()}',
                  style: AppTextStyles.body2Regular.copyWith(
                    fontWeight: FontWeight.w600,
                    //color: _amountColor(transData.transactionStatus ?? ''),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transData.statusId ?? 'status n/a',
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
