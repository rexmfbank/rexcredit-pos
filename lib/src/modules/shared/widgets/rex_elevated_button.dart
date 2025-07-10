import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexElevatedButton extends StatelessWidget {
  const RexElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.verticalPadding,
    this.isDisabled = false,
    this.textStyle,
  });

  final void Function()? onPressed;
  final String buttonTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? verticalPadding;
  final bool isDisabled;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ?? 16.ah,
      ),
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: AbsorbPointer(
          absorbing: isDisabled,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? AppColors.rexPurpleLight,
              foregroundColor: foregroundColor,
              minimumSize: Size(
                0.9 * screenWidth,
                0.15 * screenWidth,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14.0),
                ),
              ),
            ),
            child: Text(
              buttonTitle,
              style: textStyle ??
                  AppTextStyles.body1Regular.copyWith(
                    color: foregroundColor ?? AppColors.rexWhite,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
