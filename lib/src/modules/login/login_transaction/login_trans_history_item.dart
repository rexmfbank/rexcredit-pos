import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/api/models/get_balance_payload.dart';

class LoginTransactionHistoryItem extends ConsumerWidget {
  const LoginTransactionHistoryItem({
    super.key,
    required this.trans,
    required this.canTap,
  });

  final Transaction trans;
  final bool canTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap:
          canTap
              ? () {
                ref.read(memoryLoginTransProvider.notifier).state = trans;
                context.push(Routes.loginTransDetailPath);
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
                        trans.transactionDescription ?? 'n/a',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.rexPurpleDark,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8.ah),
                      Text(trans.transactionDate?.dateReadable() ?? ''),
                    ],
                  ),
                ),

                SizedBox(width: 12.aw),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${trans.transactionAmount?.toNairaAmountFormat()}',
                      style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.ah),
                    Text(
                      trans.statusId?.capitalize() ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: loginTransStatusColor(trans.statusId),
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

Color loginTransStatusColor(String? data) {
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
