import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class EmployeeCardItem extends StatelessWidget {
  final String iconPath;
  final String employeeName;
  final String employeeDesignation;
  final VoidCallback onTap;

  const EmployeeCardItem({
    super.key,
    required this.iconPath,
    required this.employeeName,
    required this.employeeDesignation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          top: 10.ah,
          left: 16.aw,
          right: 16.aw,
        ),
        padding: EdgeInsets.all(16.ar),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.ar),
        ),
        child: Row(
          children: [
            RexNetworkImage(
              image: iconPath,
              placeholderImage: iconPath,
              width: 50.aw,
              height: 50.ah,
              radius: 50.ar,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.ar),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employeeName,
                      style: AppTextStyles.body2Regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark
                      ),
                    ),
                    SizedBox(height: 4.ah),
                    Text(
                      employeeDesignation,
                      style: AppTextStyles.body1Regular.copyWith(
                          color: AppColors.rexTint500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.more_vert_rounded,
              size: 18.ar,
              color: AppColors.rexTint500,
            ),
          ],
        ),
      ),
    );
  }
}
