import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/payroll_history_item.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/payroll_pay_period_widget.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/show_payroll_actions_modal.dart';

class NonEmptyPayrollScreen extends StatelessWidget {
  const NonEmptyPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      PayPeriodWidget(
        imagePath: 'assets/png/celebration_icon.png',
        month: 'June',
        datePeriod: '(May 28, 2023 - June 28, 2023',
        onPressed: () {
          context.push(
              '${RouteName.dashboardBusiness}/${RouteName.preparePayroll}');
        },
      ),
      const SizedBox(height: 8),
      const Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Payroll History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(12),
        child: Text('See all payrolls you have create on Rex'),
      ),
      PayrollHistoryCardItem(
        employeeName: 'Payroll for June',
        employeeDesignation: '28th June 2023',
        onTap: () {
          showPayrollActionsModal(context);
        },
      ),
      PayrollHistoryCardItem(
        employeeName: 'Payroll for June',
        employeeDesignation: '28th June 2023',
        onTap: () {
          showPayrollActionsModal(context);
        },
      )
    ]);
  }
}
