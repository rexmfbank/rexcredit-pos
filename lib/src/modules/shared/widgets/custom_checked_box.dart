import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class CustomCheckedBoxWidget extends StatelessWidget {
  final String text;
  final bool isChecked;
  final Color? activeColor;
  final TextStyle? textStyle;
  final double? horizontalTextPadding;
  final ValueChanged<bool?> onChanged;

  const CustomCheckedBoxWidget({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
    this.activeColor,
    this.textStyle,
    this.horizontalTextPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.rexWhite,
          border: Border.all(color: AppColors.rexWhite, width: 1.0),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalTextPadding ?? 16.aw),
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              child: Checkbox(
                activeColor: activeColor ?? AppColors.rexGreen,
                value: isChecked,
                onChanged: onChanged,
              ),
            )
          ],
        ),
      ),
    );
  }
}
