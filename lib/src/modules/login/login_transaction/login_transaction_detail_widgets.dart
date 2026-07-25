import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/api/models/get_balance_payload.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

class LoginTransactionsDetailSummary extends StatelessWidget {
  const LoginTransactionsDetailSummary({super.key, required this.transaction});

  final Transaction transaction;

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
                "${transaction.transactionAmount?.toNairaAmountFormat()}",
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
                    "${transaction.reference}",
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
                    "${transaction.transactionDescription}",
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
              Text('n/a', style: AppTextStyles.transactionStatus),
            ],
          ),
          SizedBox(height: 12.ah),
          // transaction.tranCode == 'CARD_PURCHASE'
          //     ? SizedBox.shrink()
          //     : LoginTransactionSenderDetail(transaction: transaction),
        ],
      ),
    );
  }
}

class LoginTransactionSenderDetail extends StatelessWidget {
  const LoginTransactionSenderDetail({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sender Name'),
            Text('n/a', style: AppTextStyles.transactionStatus),
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

class LoginTransactionReportButton extends StatelessWidget {
  const LoginTransactionReportButton({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return transaction.statusId?.toLowerCase() == "successful"
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
