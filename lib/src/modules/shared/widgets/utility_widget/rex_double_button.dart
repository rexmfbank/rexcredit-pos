import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexDoubleButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? margin;
  final double? borderRadius;
  final String button1Title;
  final String button2Title;
  final Color? button1Color;
  final Color? button2Color;
  final Color? buttonBorder1Color;
  final Color? buttonBorder2Color;
  final Color? buttonText1Color;
  final Color? buttonText2Color;
  final VoidCallback? button1Tap;
  final VoidCallback? button2Tap;
  const RexDoubleButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
   required this.button1Title,
    required this.button2Title,
    this.button1Color,
    this.button2Color,
    this.buttonBorder1Color,
    this.buttonBorder2Color,
    this.buttonText1Color,
    this.buttonText2Color,
    this.button1Tap,
    this.button2Tap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin ?? 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: button1Tap,
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 15.ah, horizontal: 25.aw),
              decoration: BoxDecoration(
                color: button1Color,
                borderRadius: BorderRadius.circular(borderRadius ?? 14.ar),
                border: Border.all(
                  color: buttonBorder1Color ?? Colors.transparent,
                ),
              ),
              child: Text(
                button1Title,
                style: AppTextStyles.h2.copyWith(
                  color: buttonText1Color ?? AppColors.rexWhite,
                ),
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: button2Tap,
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 15.ah, horizontal: 25.aw),
              decoration: BoxDecoration(
                color: button2Color,
                borderRadius: BorderRadius.circular(borderRadius ?? 14.ar),
                border: Border.all(
                  color: buttonBorder2Color ?? Colors.transparent,
                ),
              ),
              child: Text(
                button2Title,
                style: AppTextStyles.h2.copyWith(
                  color: buttonText2Color ?? AppColors.rexWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
