import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexFlatButton extends StatelessWidget {
  const RexFlatButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    required this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.height,
    this.width,
    this.radius = 14.0
  });

  final void Function()? onPressed;
  final String buttonTitle;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 16.ah),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ??
                AppColors.rexPurpleDark, // Set the desired border color here
            width: borderWidth ?? 1.0.aw,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.rexPurpleLight,
            foregroundColor: AppColors.rexBackground,
            fixedSize: Size(
              width ?? 0.85 * screenWidth,
              height ?? 0.15 * screenWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(radius!),
              ),
            ),
          ),
          child: Text(
            buttonTitle,
            style: TextStyle(color: textColor ?? AppColors.rexBackground),
          ),
        ),
      ),
    );
  }
}
