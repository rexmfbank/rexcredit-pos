import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';

class PosListTile extends StatelessWidget {
  const PosListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    required this.iconPath,
    required this.iconBgColor,
    this.contentPadding,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  final Function()? onTap;
  final String iconPath;
  final String title;
  final String? subtitle;
  final Color iconBgColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: Colors.white,
      contentPadding: contentPadding ?? EdgeInsets.all(12),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(iconPath),
      ),
      title: Text(
        title,
        style: titleTextStyle ?? AppTextStyles.homeCardTheme(context),
      ),
      subtitle:
          subtitle != null ? Text('$subtitle', style: subtitleTextStyle) : null,
      onTap: onTap,
    );
  }
}
