import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class EmployeeProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String designation;

  const EmployeeProfileWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.designation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.ar),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.rexLightBlue2, Colors.white, Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 34.ah),
            Container(
              height: 91.ah,
              width: 91.aw,
              decoration: const BoxDecoration(
                color: AppColors.rexWhite,
                shape: BoxShape.circle,
              ),
              child: RexNetworkImage(
                placeholderImage: AssetPath.employeeProfilePlaceholder,
                image: imageUrl,
                height: 91.ah,
                width: 91.aw,
                radius: 100.ar,
              ),
            ),
            SizedBox(height: 10.ah),
            Text(
              name,
              style: AppTextStyles.h5.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.rexPurpleLight),
            ),
            SizedBox(height: 5.ah),
            Text(
              designation,
              style: AppTextStyles.body1Regular.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.rexTint500,
              ),
            ),
            SizedBox(height: 34.ah),
          ],
        ),
      ),
    );
  }
}
