import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmptyStaffScreen extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? buttonTitle;
  final bool showButton;
  final VoidCallback? onTap;
  const EmptyStaffScreen({
    super.key,
    this.title,
    this.subtitle,
    this.buttonTitle,
    this.showButton = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.ah),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.ah,
            child: Lottie.asset(LottieAsset.emptyStaff),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.ah),
              child: Text(
                title ?? StringAssets.noEmployeesAdded,
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.rexPurpleLight,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 56.aw),
              child: Text(
                subtitle ?? StringAssets.noEmployeesAddedSub,
                textAlign: TextAlign.center,
                style: AppTextStyles.body1Regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.rexTint500,
                  height: 1.5,
                ),
              ),
            ),
          ),
          showButton
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 20.ah, left: 104.aw, right: 104.aw),
                  child: RexFlatButton(
                    onPressed: () {
                      if (onTap != null) {
                        onTap!.call();
                        return;
                      }
                      context.push(
                          '${Routes.dashboardBusiness}/${Routes.employeePersonalDetails}');
                    },
                    buttonTitle: buttonTitle ?? StringAssets.addEmployeeCap,
                    backgroundColor: null,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
