import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexCheckbox extends StatelessWidget {
  final String text;
  final bool isChecked;
  final Color? activeColor;
  final TextStyle? textStyle;
  final double? horizontalTextPadding;
  final ValueChanged<bool?> onChanged;
  final VoidCallback? onTap;

  const RexCheckbox({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
    this.activeColor,
    this.textStyle,
    this.horizontalTextPadding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap?.call(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.ar),
                ),
              ),
            ),
            child: SizedBox(
              height: 17.ah,
              child: AbsorbPointer(
                child: Checkbox(
                  activeColor: activeColor ?? AppColors.rexGreen,
                  value: isChecked,
                  onChanged: onChanged,
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalTextPadding ?? 16.aw),
            child: Text(
              text,
              style: textStyle ?? AppTextStyles.body1Regular.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textBlack.withOpacity(0.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
