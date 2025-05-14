import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/employee_card_item.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class CashflowSingleReceiptScreen extends StatelessWidget {
  const CashflowSingleReceiptScreen({super.key});

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
                  child: TransferBeneficiarySearchBar(),
                ),
                const SizedBox(width: 4),
                Image.asset(
                  'assets/png/filter_icon.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          ),
          EmployeeCardItem(
            iconPath: 'assets/png/acrobat_icon.png',
            employeeName: 'Moses Simon Invoice',
            employeeDesignation: 'Product Design',
            onTap: () {
              context
                  .push('${Routes.dashboardBusiness}/${Routes.singleEmployee}');
            },
          )
        ],
      ),
    );
  }
}
