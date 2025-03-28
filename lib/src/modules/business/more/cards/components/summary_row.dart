import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class SummaryRow extends StatelessWidget {
  final String title;
  final String info;
  const SummaryRow({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.ah),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyles.body1Regular.copyWith(
                  color: AppColors.textBrown,
                ),
              ),
              Text(
                info,
                style: AppTextStyles.body1Regular.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlackTint,
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 0.5.ah,
          color: AppColors.cancelGrey,
        ),
      ],
    );
  }
}
