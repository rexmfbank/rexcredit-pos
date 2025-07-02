import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class RexListTile extends StatelessWidget {
  const RexListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.hasTrailingIcon,
    this.status,
    this.titleTextColor,
    this.tileColor,
    this.onTap,
    this.verifiedField = false,
    this.visible = true,
    this.trailingIcon,
    this.leadingWidget,
  });

  final String title;
  final String? subtitle;
  final String? status;
  final bool hasTrailingIcon;
  final Color? titleTextColor;
  final Color? tileColor;
  final void Function()? onTap;
  final bool verifiedField;
  final bool visible;
  final Widget? trailingIcon;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.ah, horizontal: 15.aw),
        child: ListTile(
          onTap: verifiedField ? null : onTap,
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.ah, horizontal: 18.aw),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.ar),
          ),
          tileColor: tileColor?.withOpacity(0.3) ??
              (verifiedField ? AppColors.cardBrown : AppColors.rexWhite),
          leading: leadingWidget,
          title: Padding(
            padding: EdgeInsets.only(bottom: 4.ah),
            child: Text(
              title,
              style: TextStyle(
                color: tileColor ??
                    (verifiedField
                        ? AppColors.rexBrown2
                        : titleTextColor ?? AppColors.rexPurpleDark),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle!,
                      style: TextStyle(
                          color: tileColor ??
                              (verifiedField
                                  ? AppColors.rexBrown2
                                  : AppColors.rexTint500),
                          fontSize: 13),
                    ),
                    if (status.isNotBlank) ...[
                      SizedBox(height: 4.ah),
                      Text(
                        status!,
                        style: AppTextStyles.body3Regular.copyWith(
                          fontWeight: FontWeight.w700,
                          color: tileColor ??
                              (verifiedField
                                  ? AppColors.rexBrown2
                                  : AppColors.rexTint500),
                        ),
                      ),
                    ],
                  ],
                ),
          trailing: hasTrailingIcon
              ? verifiedField
                  ? Icon(
                      Icons.check_circle_outline_rounded,
                      color: tileColor ?? AppColors.rexBrown2,
                    )
                  : Icon(
                      Icons.navigate_next_outlined,
                      color: tileColor ?? AppColors.rexPurpleDark,
                    )
              : trailingIcon,
        ),
      ),
    );
  }
}
