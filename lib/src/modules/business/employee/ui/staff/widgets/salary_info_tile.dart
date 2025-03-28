import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class SalaryInfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool filled;
  final VoidCallback onTap;

  const SalaryInfoTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10.ah, left: 16.aw, right: 16.aw),
        padding: EdgeInsets.all(16.ar),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.ar),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.ar),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body2Regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark),
                    ),
                    SizedBox(height: 4.ah),
                    Text(
                      subtitle,
                      style: AppTextStyles.body1Regular.copyWith(
                        color: AppColors.rexTint500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            !filled
                ? Icon(
                    Icons.arrow_forward_ios,
                    size: 18.ar,
                    color: AppColors.rexTint500,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(35.ar),
                    child: Icon(
                      Icons.check_box_sharp,
                      size: 28.ar,
                      color: AppColors.checkGreen,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
