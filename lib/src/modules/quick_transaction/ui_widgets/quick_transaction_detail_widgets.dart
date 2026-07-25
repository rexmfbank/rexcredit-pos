import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

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
        color: AppColors.rexWhite,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Amount'),
              Text(
                "NGN ${posTransaction.amount?.toCommaSeparatedWithDecimals()}",
                style: AppTextStyles.transactionStatus,
              ),
            ],
          ),
          SizedBox(height: 12.ah),
          Row(
            children: [
              Text('Transaction Ref'),
              SizedBox(width: 8),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${posTransaction.tranRefNo}",
                    textAlign: TextAlign.right,
                    style: AppTextStyles.transactionStatus,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.ah),
          Row(
            children: [
              Text('Description'),
              SizedBox(width: 8),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${posTransaction.narration}",
                    textAlign: TextAlign.right,
                    style: AppTextStyles.transactionStatus,
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 10.ah),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('Beneficiary'),
          //     Text(
          //       '${posTransaction.beneficiaryBank }', // no beneficiaryName
          //       style: AppTextStyles.transactionStatus,
          //     ),
          //   ],
          // ),
          SizedBox(height: 12.ah),
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
          SizedBox(height: 12.ah),
          posTransaction.tranCode == 'CARD_PURCHASE'
              ? SizedBox.shrink()
              : QuickTransactionSenderDetail(posTransaction: posTransaction),
        ],
      ),
    );
  }
}

class QuickTransactionSenderDetail extends StatelessWidget {
  const QuickTransactionSenderDetail({super.key, required this.posTransaction});

  final PosTransactionsResponseData posTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sender Name'),
            Text(
              '${posTransaction.senderName}',
              style: AppTextStyles.transactionStatus,
            ),
          ],
        ),
        SizedBox(height: 12.ah),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sender Account'),
            Text(
              'n/a', // no senderAccountNumber
              style: AppTextStyles.transactionStatus,
            ),
          ],
        ),
        SizedBox(height: 12.ah),
      ],
    );
  }
}

class QuickTransactionReportButtonn extends StatelessWidget {
  const QuickTransactionReportButtonn({
    super.key,
    required this.posTransaction,
  });

  final PosTransactionsResponseData posTransaction;

  @override
  Widget build(BuildContext context) {
    return posTransaction.status!.toLowerCase() == "successful"
        ? SizedBox.shrink()
        : RexElevatedButton(
          backgroundColor: Color(0xffFF0000),
          foregroundColor: AppColors.rexWhite,
          onPressed: () {
            context.push(Routes.createDispute);
          },
          buttonTitle: 'Report this transaction',
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        );
  }
}
