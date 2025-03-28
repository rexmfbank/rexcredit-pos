import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/show_receipt_actions_modal.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/employee_card_item.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class CashFlowReceiptsScreen extends StatelessWidget {
  const CashFlowReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Receipts',
        subtitle: 'View and manage invoices on Rex',
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: TransferBeneficiarySearchBar(
                    hintText: 'Search by anything',
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset(
                  'assets/png/filter_2_icon.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Receipt',
            employeeDesignation: 'Receipt ID #00001',
            onTap: () {
              showReceiptActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Receipt',
            employeeDesignation: 'Receipt ID #00002',
            onTap: () {
              showReceiptActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Receipt',
            employeeDesignation: 'Receipt ID #00003',
            onTap: () {
              showReceiptActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Receipt',
            employeeDesignation: 'Receipt ID #00004',
            onTap: () {
              showReceiptActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Abiola Receipt',
            employeeDesignation: 'Receipt ID #00002',
            onTap: () {
              showReceiptActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moshood Jareem Receipt',
            employeeDesignation: 'Product Design',
            onTap: () {
              showReceiptActionsModal(context);
            },
          ),
        ],
      ),
    );
  }
}
