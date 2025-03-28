import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class RexRichText extends StatelessWidget {
  const RexRichText({
    super.key,
    required this.title1,
    this.textStyle1,
    required this.title2,
    this.onTap,
    this.textDecoration2,
    this.color2,
    this.alignment,
  });

  final String title1;
  final TextStyle? textStyle1;
  final String title2;
  final void Function()? onTap;
  final TextDecoration? textDecoration2;
  final Color? color2;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title1,
                style: textStyle1 ??
                    const TextStyle(
                      color: AppColors.rexPurpleDark,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              TextSpan(
                text: title2,
                style: TextStyle(
                  color: color2 ?? AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w500,
                  decoration: textDecoration2 ?? TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
