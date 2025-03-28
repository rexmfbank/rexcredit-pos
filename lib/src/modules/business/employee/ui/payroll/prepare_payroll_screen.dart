import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/prepare_payroll_staff_item.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PreparePayrollScreen extends StatefulHookConsumerWidget {
  const PreparePayrollScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreparePayrollScreenState();
}

class _PreparePayrollScreenState extends ConsumerState<PreparePayrollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Prepare Payroll',
        subtitle: StringAssets.preparePayrollSubtitle,
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
          PreparePayrollStaffCardItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobi Modupe',
            employeeDesignation: 'VP, Engineering',
            onTap: () {},
          ),
          PreparePayrollStaffCardItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobi Modupe',
            employeeDesignation: 'VP, Engineering',
            onTap: () {},
          ),
          PreparePayrollStaffCardItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobi Modupe',
            employeeDesignation: 'VP, Engineering',
            onTap: () {},
          ),
          PreparePayrollStaffCardItem(
            iconPath: 'assets/png/sample_profile_2.png',
            employeeName: 'Tobi Modupe',
            employeeDesignation: 'VP, Engineering',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                context.push(
                    '${RouteName.dashboardBusiness}/${RouteName.preparePayrollEmployeeLoan}');
              },
              buttonTitle: StringAssets.proceed,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
