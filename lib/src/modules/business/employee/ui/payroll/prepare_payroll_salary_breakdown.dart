import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/payroll_view_payslip_item.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class PayrollReviewSalaryScreen extends StatefulHookConsumerWidget {
  const PayrollReviewSalaryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PayrollReviewSalaryScreenState();
}

class _PayrollReviewSalaryScreenState
    extends ConsumerState<PayrollReviewSalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Review Salary Breakdown',
        subtitle:
            'Review or adjust employee payslips to get them ready for the payroll period.',
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
                    hintText: 'Search by Name',
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset(
                  height: 50,
                  width: 50,
                  'assets/png/filter_icon.png',
                )
              ],
            ),
          ),
          PayrollViewPayslipItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobi Modupe',
            netPay: '240,000',
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.employeePayslip}');
            },
          ),
          PayrollViewPayslipItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobi Modupe',
            netPay: '240,000',
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.employeePayslip}');
            },
          ),
          PayrollViewPayslipItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobi Modupe',
            netPay: '240,000',
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.employeePayslip}');
            },
          ),
          PayrollViewPayslipItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Elon Black',
            netPay: '240,000',
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.employeePayslip}');
            },
          ),
          PayrollViewPayslipItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobe Farlon',
            netPay: '20,000',
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.employeePayslip}');
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                context.push(
                    '${RouteName.dashboardBusiness}/${RouteName.payrollSummary}');
              },
              buttonTitle: 'Submit Payroll',
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
