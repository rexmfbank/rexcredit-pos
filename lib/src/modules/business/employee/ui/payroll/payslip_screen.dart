import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/payslip_personal_information_card.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/payslip_salary_breakdown_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class PayslipScreen extends StatefulHookConsumerWidget {
  const PayslipScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends ConsumerState<PayslipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Payslip from Space X',
        subtitle: 'Payslip for 28th of April 2023',
      ),
      body: ListView(
        children: [
          const PayslipPersonalInfromationCard(
              accountName: 'Ani Mike',
              accountNumber: '908754372',
              bankName: 'MainOne Bank'),
          const PayslipPersonalSalaryBreakdownCard(
            basic: '450,000',
            transport: '100,000',
            housing: '30,000',
            tax: '80,000',
            deduction: '3,000',
            bonus: '15,0000',
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                // context.push(
                //     '${RouteName.dashboardHomeBusiness}/${RouteName.reviewSalaryBreakdown}');
              },
              buttonTitle: 'Download Payslip',
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
