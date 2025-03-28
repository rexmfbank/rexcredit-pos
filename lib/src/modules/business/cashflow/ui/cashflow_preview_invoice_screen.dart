import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/custom_table_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class CashFlowPreviewInvoiceScreen extends StatelessWidget {
  const CashFlowPreviewInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Invoice #0001',
        subtitle: 'This is a preview of your invoice',
      ),
      body: ListView(
        children: [
          const InvoiceSummaryWidget(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RexFlatButton(
                onPressed: () {
                  showSuccessModal(
                      context,
                      'Invoice Sent!',
                      'You have successfully sent invoice',
                      'Ok',
                      'success_tick',
                      () {});
                },
                buttonTitle: 'Send Invoice',
                backgroundColor: null),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: RexFlatButton(
                onPressed: () {},
                buttonTitle: 'Download Invoice',
                textColor: AppColors.rexPurpleDark,
                backgroundColor: AppColors.rexBackground),
          )
        ],
      ),
    );
  }
}

class InvoiceSummaryWidget extends StatelessWidget {
  const InvoiceSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> tableData = [
      {'number': '1', 'items': 'Item 1', 'qty': '2', 'price': '\$10'},
      {'number': '2', 'items': 'Item 2', 'qty': '3', 'price': '\$15'},
      {'number': '3', 'items': 'Item 3', 'qty': '1', 'price': '\$5'},
      // Add more data as needed
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/png/rex_circle_logo.png',
                  height: 60,
                  width: 60,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rex Africa',
                      style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Rexfinance@Rex.co',
                      style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Invoice No: #00001',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            const Chip(label: Text('26, May 2023')),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bill to:',
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Customer Name',
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rexfinance@Rex.co',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            CustomTableWidget(data: tableData),
            const PlanSummaryDivider(),
            const Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Text('Tax Amount'),
                    SizedBox(width: 12),
                    Text(
                      'N0.00',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    Text('Discount'),
                    SizedBox(width: 12),
                    Text(
                      'N0.00',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    Text('Total Amount'),
                    SizedBox(width: 12),
                    Text(
                      'N500,000.00',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Note:',
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              'This is just a note. Could be used to display further information',
              style: TextStyle(
                color: AppColors.rexTint500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pay Now',
              style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}
