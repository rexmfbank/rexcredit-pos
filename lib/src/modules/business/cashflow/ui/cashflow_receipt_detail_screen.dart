import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/custom_table_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class CashFlowReceiptDetailScreen extends StatelessWidget {
  const CashFlowReceiptDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Receipt #00001',
        subtitle: '28th June 2023',
      ),
      body: ListView(
        children: [
          const ReceiptSummaryWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {},
              buttonTitle: 'Send Receipt',
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiptSummaryWidget extends StatelessWidget {
  const ReceiptSummaryWidget({
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
        padding: EdgeInsets.all(16),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
                    'Receipt No: #00001',
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
                'Paid by:',
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
                'Rex Credit',
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
          ],
        ),
      ),
    );
  }
}
