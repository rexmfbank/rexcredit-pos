import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/show_invoice_action_modal.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/show_transaction_filter_modal.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/employee_card_item.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class CashFlowAllInvoiceScreen extends StatelessWidget {
  const CashFlowAllInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'All Invoices',
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
                    hintText: 'Search for invoice',
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  child: Image.asset(
                    'assets/png/filter_2_icon.png',
                    height: 50,
                    width: 50,
                  ),
                  onTap: () {
                    showTransactionFilterModal(context);
                  },
                ),
              ],
            ),
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              showInvoiceActionsModal(context);
            },
          )
        ],
      ),
    );
  }
}
