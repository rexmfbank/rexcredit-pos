import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/empty_staff_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/add_new_payroll_item_button.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/payroll_item_tile.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/payroll_item_types.dart';

class EmployeeDeductionsList extends ConsumerWidget {
  const EmployeeDeductionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const RexAppBar(
        stepValue: 3,
        totalStepValue: 4,
        shouldHaveBackButton: true,
        title: StringAssets.deductions,
        subtitle: StringAssets.enterDeductions,
      ),
      body: Builder(
        builder: (context) {
          if (ref.watch(employeeNotifier).payrollItems.any((element) =>
              element.type == PayrollItemTypes.deduction.jsonString)) {
            final deductions = ref.watch(employeeNotifier).payrollItems.where(
                (element) =>
                    element.type == PayrollItemTypes.deduction.jsonString);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.aw),
                  child: AddNewPayrollItemButton(
                    title: StringAssets.addDeductions,
                    onTap: () => context.push(
                        '${Routes.dashboardBusiness}/${Routes.enterEmployeeDeductions}'),
                  ),
                ),
                SizedBox(height: 30.ah),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => PayrollItemTile(
                      title: deductions.elementAt(index).title!,
                      amount: deductions.elementAt(index).amount.toString(),
                    ),
                    itemCount: deductions.length,
                  ),
                ),
              ],
            );
          }

          return EmptyStaffScreen(
            title: StringAssets.noDeductionsAdded,
            subtitle: StringAssets.noDeductionsAddedSub,
            buttonTitle: StringAssets.addDeductions,
            onTap: () => context.push(
                '${Routes.dashboardBusiness}/${Routes.enterEmployeeDeductions}'),
          );
        },
      ),
    );
  }
}
