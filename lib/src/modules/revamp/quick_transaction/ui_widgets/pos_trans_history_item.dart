import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/api/rex_api.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class PosTransHistoryItem extends ConsumerWidget {
  const PosTransHistoryItem({
    super.key,
    required this.trans,
    required this.canTap,
  });

  final PosTransactionsResponseData trans;
  final bool canTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap:
          canTap
              ? () {
                ref.read(inMemoryTransactionProvider.notifier).state = trans;
                context.push(Routes.quickTransactionDetail);
              }
              : null,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 12.0, bottom: 8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trans.narration ?? 'n/a',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.rexPurpleDark,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8.ah),
                      Text(trans.tranDate?.toPosTime() ?? ''),
                    ],
                  ),
                ),

                SizedBox(width: 12.aw),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₦${trans.amount?.toCommaSeparatedWithDecimals()}',
                      style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.ah),
                    Text(
                      trans.status?.toUpperCase() ?? 'N/A',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: transactionStatusColor(trans.status),
                      ),
                    ),
                  ],
                ),

                Icon(Icons.navigate_next_sharp, color: AppColors.rexBlack),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

Color transactionStatusColor(String? data) {
  if (data == null) {
    return AppColors.rexBlack;
  } else if (data.toLowerCase() == 'successful') {
    return AppColors.rexGreen;
  } else if (data.toLowerCase() == 'pending') {
    return AppColors.rexLightBlue2;
  } else if (data.toLowerCase() == 'failed') {
    return AppColors.red;
  } else {
    return AppColors.rexBlack;
  }
}
