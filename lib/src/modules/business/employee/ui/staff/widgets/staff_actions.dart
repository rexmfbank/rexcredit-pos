import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class StaffActions extends ConsumerWidget {
  final EmployeeInfoDTO employeeInfo;
  const StaffActions({
    super.key,
    required this.employeeInfo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(16.ar),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(8.ar),
            child: Text(
              StringAssets.actions,
              style: AppTextStyles.h5.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.aw),
            child: Text(
              StringAssets.seeWhatYouCanDo,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.rexTint500,
              ),
            ),
          ),
          SizedBox(height: 8.ah),
          // CustomerTile(
          //   icon: AssetPath.showIcon,
          //   title: StringAssets.editEmployeeDetails,
          //   subtitle: StringAssets.updateEmployeeDetails,
          //   onTap: () {
          //     context.pop();
          //     ref.watch(employeeNotifier.notifier).selectEmployee(employeeInfo);
          //     ref.watch(employeeNotifier.notifier).setEditAction(true);
          //     context.push(
          //         '${RouteName.dashboardBusiness}/${RouteName.singleEmployee}');
          //   },
          // ),
          // CustomerTile(
          //   icon: AssetPath.pocketIcon,
          //   title: StringAssets.removeEmployee,
          //   subtitle: StringAssets.deleteEmployeeRecord,
          //   onTap: () {
          //     ref.watch(employeeNotifier.notifier).deleteEmployee(
          //           context: context,
          //           staffCode: employeeInfo.businessStaffCode ?? '',
          //         );
          //   },
          // ),
          SizedBox(height: 5.ah),
          RexFlatButton(
            onPressed: () => context.pop(),
            buttonTitle: StringAssets.closeTextOnButton,
            textColor: AppColors.rexPurpleLight,
            backgroundColor: AppColors.rexWhite,
          ),
        ],
      ),
    );
  }
}
