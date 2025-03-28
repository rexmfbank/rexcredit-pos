import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AddNewEmployeeCard extends ConsumerWidget {
  const AddNewEmployeeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(employeeNotifier.notifier).setEditAction(false);
        ref.watch(employeeNotifier.notifier).clearFields();
        context.push(
            '${RouteName.dashboardBusiness}/${RouteName.employeePersonalDetails}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 8.ah),
        padding: EdgeInsets.all(11.ar),
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(16.ar),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 60.ah,
              child:
                  Lottie.asset(LottieAsset.addProfilePicture),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.ar),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringAssets.addEmployee,
                      style: AppTextStyles.body2Regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexGreen2
                      ),
                    ),
                    SizedBox(height: 4.ah),
                    Text(
                      StringAssets.addEmployeeSub,
                      style: AppTextStyles.body1Regular.copyWith(
                          color: AppColors.rexGreen2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(AssetPath.plusButtonIcon),
          ],
        ),
      ),
    );
  }
}
