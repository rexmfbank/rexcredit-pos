import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/cashflow_create_invoice_card.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/cashflow_invoice_status_card.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/show_invoice_action_modal.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/employee_card_item.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/rex_savings_balance_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/currency.dart';

class CashflowInvoiceScreen extends StatefulHookConsumerWidget {
  const CashflowInvoiceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashflowInvoiceScreenState();
}

class _CashflowInvoiceScreenState extends ConsumerState<CashflowInvoiceScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Invoices',
        subtitle: 'View and manage invoices on Rex',
      ),
      body: ListView(
        children: [
          RexSavingsBalanceCard(
            cardTitle: 'Total Invoice Paid',
            iconPath: 'assets/png/total_invoice_icon.png',
            total: addNairaCurrencySymbol('1,453,962'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                InvoicePaymentStatusCard(
                  cardBackgroundColor: AppColors.cardGreen,
                  titleText: 'Paid Invoice',
                  totalText: '1',
                ),
                SizedBox(width: 8.0),
                InvoicePaymentStatusCard(
                  cardBackgroundColor: AppColors.cardBrown,
                  titleText: 'Unpaid Invoice',
                  totalText: '2',
                ),
              ],
            ),
          ),
          CreateInvoiceCard(
            cardTitle: 'Create Invoice',
            iconPath: 'assets/png/plus_button_green.png',
            total: 'Customize your invoice form with Rex',
            onIconTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.manageInvoice}');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Invoice',
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.rexPurpleDark,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(
                        '${RouteName.dashboardBusiness}/${RouteName.cashflowAllInvoice}');
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(color: AppColors.grey, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: data.length,
          //   itemBuilder: (context, index) {
          //     return RegularSavingsTransactionCardItem(
          //       data: data[index],
          //     );
          //   },
          // ),
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
