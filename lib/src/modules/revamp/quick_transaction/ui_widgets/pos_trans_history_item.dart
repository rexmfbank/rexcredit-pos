import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 12.0, bottom: 8.0),
      child: GestureDetector(
        onTap:
            canTap
                ? () {
                  ref.read(inMemoryTransactionProvider.notifier).state = trans;
                  context.push(Routes.quickTransactionDetail);
                }
                : null,
        child: Column(
          children: [
            SizedBox(height: 8.ah),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trans.narration ?? 'N/A',
                      style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.ah),
                    Text(trans.tranDate?.toPosTime() ?? ''),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₦${trans.amount?.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.rexPurpleDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.ah),
                        Text(
                          trans.paymentStatus ?? 'N/A',
                          style: TextStyle(
                            color: transactionStatusColor(trans.paymentStatus),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.navigate_next_sharp, color: AppColors.rexBlack),
                  ],
                ),
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
  } else if (data == StringAssets.successful) {
    return AppColors.rexGreen;
  } else if (data == StringAssets.pending) {
    return AppColors.rexLightBlue2;
  } else if (data == StringAssets.failedCap) {
    return AppColors.red;
  } else {
    return AppColors.rexBlack;
  }
}
