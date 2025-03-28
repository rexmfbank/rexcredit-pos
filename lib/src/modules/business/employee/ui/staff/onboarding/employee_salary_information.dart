import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/salary_info_tile.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmployeeSalaryInformationScreen extends ConsumerStatefulWidget {
  final bool edit;
  const EmployeeSalaryInformationScreen({super.key, this.edit = false});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeeSalaryInformationScreenState();
}

class _EmployeeSalaryInformationScreenState
    extends ConsumerState<EmployeeSalaryInformationScreen> {

  @override
  void initState() {
    if(widget.edit){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(employeeNotifier.notifier).clearFields();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const RexAppBar(
        stepValue: 3,
        totalStepValue: 4,
        shouldHaveBackButton: true,
        title: StringAssets.employeeSalaryInfo,
        subtitle: StringAssets.employeeSalaryInfoSub,
      ),
      body: ListView(
        children: [
          SalaryInfoTile(
            title: StringAssets.salaryAmount,
            subtitle: StringAssets.salaryAmountCurrency,
            filled: ref.watch(employeeNotifier).salaryFilled,
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.enterSalaryAmount}');
            },
          ),
          SalaryInfoTile(
            title: StringAssets.allowances,
            subtitle: StringAssets.enterAllowances,
            filled: ref.watch(employeeNotifier).allowanceFilled,
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.employeeAllowancesList}');
            },
          ),
          SalaryInfoTile(
            title: StringAssets.deductions,
            subtitle: StringAssets.enterDeductions,
            filled: ref.watch(employeeNotifier).deductionFilled,
            onTap: () {
              context.push(
                  '${RouteName.dashboardBusiness}/${RouteName.employeeDeductionsList}');
            },
          ),
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexElevatedButton(
              onPressed: () => ref.watch(employeeNotifier.notifier).validateStaffSalaryFields(context),
              buttonTitle: StringAssets.nextTextOnButton,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
