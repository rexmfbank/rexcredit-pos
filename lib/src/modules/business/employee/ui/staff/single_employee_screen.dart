import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/employee_profile_widget.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/single_employee_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_option_with_icon_item_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SingleEmployeeScreen extends ConsumerWidget {
  const SingleEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(employeeNotifier).isLoading,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: RexAppBar(
        barHeight: 75.ah,
        shouldHaveBackButton: true,
        title: StringAssets.emptyString,
        subtitle: StringAssets.emptyString,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: EmployeeProfileWidget(
              imageUrl:
                  ref.watch(employeeNotifier).selectedEmployeeRes?.photoLink ??
                      '',
              name:
                  '${ref.watch(employeeNotifier).selectedEmployeeRes?.firstname ?? ''} ${ref.watch(employeeNotifier).selectedEmployeeRes?.lastname ?? ''}',
              designation: ref
                      .watch(employeeNotifier)
                      .selectedEmployeeRes
                      ?.designation ??
                  '',
            ),
          ),
          SizedBox(height: 8.ah),
          InvestmentTypeCard(
            iconPath: AssetPath.profileIcon,
            investmentTitle: StringAssets.personalDetailsTitle,
            investmentSubTitle: StringAssets.personalDetailsEmployeeSub,
            onTap: () {
              context.push(
                '${RouteName.dashboardBusiness}/${RouteName.employeePersonalDetails}',
                extra: true,
              );
            },
          ),
          InvestmentTypeCard(
            iconPath: AssetPath.pocketIcon,
            investmentTitle: StringAssets.employeeWorkInfo,
            investmentSubTitle: StringAssets.employeeWorkInfoEmployeeSub,
            onTap: () {
              context.push(
                '${RouteName.dashboardBusiness}/${RouteName.employeeWorkInformation}',
                extra: true,
              );
            },
          ),
          InvestmentTypeCard(
            iconPath: AssetPath.pocketIcon,
            investmentTitle: StringAssets.employeeSalaryInfo,
            investmentSubTitle: StringAssets.employeeSalaryInfoEmployeeSub,
            onTap: () {
              context.push(
                '${RouteName.dashboardBusiness}/${RouteName.enterSalaryAmount}',
                extra: true,
              );
            },
          ),
          InvestmentTypeCard(
            iconPath: AssetPath.pocketIcon,
            investmentTitle: StringAssets.bankInformation,
            investmentSubTitle: StringAssets.bankInformationEmployeeSub,
            onTap: () {
              context.push(
                '${RouteName.dashboardBusiness}/${RouteName.enterEmployeeBankInformation}',
                extra: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
