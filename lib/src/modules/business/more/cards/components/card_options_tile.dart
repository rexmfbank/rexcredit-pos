import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class CardOptionsTile extends StatelessWidget {
  final String icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;
  final Color? arrowColor;
  final VoidCallback? onTap;
  const CardOptionsTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.textColor,
    this.arrowColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap?.call(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 9.ah),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon.contains('.svg')
                    ? SvgPicture.asset(
                  icon,
                  height: 24.ah,
                  width: 24.aw,
                  color: iconColor,
                )
                    : Image.asset(
                  icon,
                  height: 24.ah,
                  width: 24.aw,
                  color: iconColor,
                ),
                SizedBox(width: 8.aw),
                Text(
                  title,
                  style: AppTextStyles.body2Regular.copyWith(
                    fontWeight: FontWeight.w500,
                    color: textColor ?? AppColors.textBlackTint,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14.ar,
                  color: arrowColor ?? AppColors.textGrey,
                ),
              ],
            ),
            SizedBox(height: 12.ah),
            Divider(
              thickness: 0.5.ah,
              color: AppColors.cancelGrey,
            ),
          ],
        ),
      ),
    );
  }
}
