import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';

import 'package:rex_app/src/modules/business/employee/ui/components/total_salary_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/rex_savings_balance_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class PayrollSummaryScreen extends StatefulHookConsumerWidget {
  const PayrollSummaryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PayrollSummaryScreenState();
}

class _PayrollSummaryScreenState extends ConsumerState<PayrollSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Payroll Summary',
        subtitle: 'Summary of your payroll and what gets debited',
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: PayrollSummaryWidget(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: PayrollBreakdownWidget(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                showSuccessModal(
                    context,
                    'Payments Successful!',
                    'You have successfully ran payroll for June 2023',
                    'Ok',
                    'success_tick', () {
                  context.go(
                      '${RouteName.dashboardBusiness}/${RouteName.dashboardEmployees}');
                });
              },
              buttonTitle: 'Run Payroll',
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}

class PayrollBreakdownWidget extends StatelessWidget {
  const PayrollBreakdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Deductions',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TotalSalaryCard(
                  cardTitle: 'Total Gross Salary',
                  total: 'N25,000',
                  backgroundColor: const Color(0xffFFEDED),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TotalSalaryCard(
                  cardTitle: 'Total Net Salary',
                  total: 'N20,500',
                  backgroundColor: const Color(0xffFFEDED),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PayrollSummaryWidget extends StatelessWidget {
  const PayrollSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          RexSavingsBalanceCard(
            cardTitle: 'Total Number of Employees',
            total: '25',
            iconPath: 'assets/png/briefcase_staff_icon.png',
            backgroundColor: const Color(0xffFEF6E6),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TotalSalaryCard(
                  cardTitle: 'Total Gross Salary',
                  total: 'N25,000',
                  backgroundColor: const Color(0xffFEF6E6),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TotalSalaryCard(
                  cardTitle: 'Total Net Salary',
                  total: 'N20,500',
                  backgroundColor: const Color(0xffFEF6E6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
