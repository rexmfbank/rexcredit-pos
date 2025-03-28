import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FormAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackButtonPressed,
    this.bold = false,
    this.titleColor,
    this.subtitleColor,
  });

  final String title;
  final String? subtitle;
  final bool bold;
  final Color? titleColor;
  final Color? subtitleColor;
  final VoidCallback? onBackButtonPressed;

  @override
  Size get preferredSize => const Size.fromHeight(150.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.ah, horizontal: 16.aw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              color: AppColors.rexPurpleDark,
              onPressed: onBackButtonPressed,
            ),
            SizedBox(height: 19.ah),
            Text(
              title,
              style: AppTextStyles.h4.copyWith(
                fontWeight: FontWeight.w700,
                color: titleColor ?? AppColors.textBlack,
              ),
            ),
            if(subtitle.isNotBlank) ...[
              SizedBox(height: 8.ah),
              Text(
                subtitle!,
                style: AppTextStyles.body1Regular.copyWith(
                  fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                  color: subtitleColor ?? AppColors.rexTint500,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
