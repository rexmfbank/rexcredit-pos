import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/transactions/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class TransactionDetailScreen extends ConsumerStatefulWidget {
  const TransactionDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState
    extends ConsumerState<TransactionDetailScreen> {
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
                    Text("NGN${detail.amount}"),
                  ],
                ),
                SizedBox(height: 8.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transaction Ref'),
                    Text("${detail.tranUniqRefNo}"),
                  ],
                ),
                SizedBox(height: 8.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Beneficiary'),
                    Text('${detail.beneficiaryName}'),
                  ],
                ),
                SizedBox(height: 8.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Beneficiary Account'),
                    Text('${detail.beneficiaryAccountNo}'),
                  ],
                ),
                SizedBox(height: 8.ah),
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
            onPressed: () {},
            buttonTitle: 'Print Receipt',
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
