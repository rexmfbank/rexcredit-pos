import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class QuickTransactionsDetailScreen extends ConsumerStatefulWidget {
  const QuickTransactionsDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransactionDetailScreen();
}

class _QuickTransactionDetailScreen
    extends ConsumerState<QuickTransactionsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(inMemoryTransactionProvider);
    return AppScaffold(
      appBar: AppbarSubScreen(title: 'Transaction Details'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexLightBlue4,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount'),
                    Text(
                      "NGN ${detail.amount}",
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
                SizedBox(height: 10.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transaction Ref'),
                    Flexible(
                      child: Text(
                        "${detail.tranUniqRefNo}",
                        textAlign: TextAlign.right,
                        style: AppTextStyles.transactionStatus,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Beneficiary'),
                    Text(
                      '${detail.beneficiaryName}',
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
                SizedBox(height: 10.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Beneficiary Account'),
                    Text(
                      '${detail.beneficiaryAccountNo}',
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
                SizedBox(height: 10.ah),
              ],
            ),
          ),
          SizedBox(height: 8.ah),
          RexElevatedButton(
            backgroundColor: AppColors.rexLightBlue4,
            foregroundColor: AppColors.rexPurpleDark,
            onPressed: () {},
            buttonTitle: 'Report this transaction',
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.ah),
          RexElevatedButton(
            onPressed: () {
              ref
                  .read(posGlobalProvider.notifier)
                  .printQuickTransactionDetail(context: context, data: detail);
            },
            buttonTitle: 'Print Receipt',
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
