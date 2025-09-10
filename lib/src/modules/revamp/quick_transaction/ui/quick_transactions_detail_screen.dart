import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class QuickTransactionsDetailScreen extends ConsumerStatefulWidget {
  const QuickTransactionsDetailScreen({super.key, this.data});

  final PosTransactionsResponseData? data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransactionDetailScreen();
}

class _QuickTransactionDetailScreen
    extends ConsumerState<QuickTransactionsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final detail =
        widget.data == null
            ? ref.watch(inMemoryTransactionProvider)
            : widget.data!;
    //
    return AppScaffold(
      appBar: AppbarSubScreen(title: 'Transaction Details'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          QuickTransactionsDetailSummary(posTransaction: detail),
          SizedBox(height: 8.ah),
          RexElevatedButton(
            backgroundColor: AppColors.rexLightBlue4,
            foregroundColor: AppColors.rexPurpleDark,
            onPressed: () {
              context.push(Routes.createDispute);
            },
            buttonTitle: 'Report Transaction',
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

class QuickTransactionsDetailSummary extends StatelessWidget {
  const QuickTransactionsDetailSummary({
    super.key,
    required this.posTransaction,
  });

  final PosTransactionsResponseData posTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "NGN ${posTransaction.amount}",
                style: AppTextStyles.transactionStatus,
              ),
            ],
          ),
          SizedBox(height: 10.ah),
          Row(
            children: [
              Text('Transaction Ref'),
              SizedBox(width: 8),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${posTransaction.tranUniqRefNo}",
                    textAlign: TextAlign.right,
                    style: AppTextStyles.transactionStatus,
                  ),
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
                '${posTransaction.beneficiaryName}',
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
                '${posTransaction.beneficiaryAccountNo}',
                style: AppTextStyles.transactionStatus,
              ),
            ],
          ),
          SizedBox(height: 10.ah),
          posTransaction.tranType == 'PURCHASE'
              ? SizedBox.shrink()
              : TransSenderDetail(posTransaction: posTransaction),
        ],
      ),
    );
  }
}

class TransSenderDetail extends StatelessWidget {
  const TransSenderDetail({super.key, required this.posTransaction});

  final PosTransactionsResponseData posTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sender'),
            Text(
              '${posTransaction.senderName}',
              style: AppTextStyles.transactionStatus,
            ),
          ],
        ),
        SizedBox(height: 10.ah),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sender Account'),
            Text(
              '${posTransaction.senderAccountNumber}',
              style: AppTextStyles.transactionStatus,
            ),
          ],
        ),
        SizedBox(height: 10.ah),
      ],
    );
  }
}
