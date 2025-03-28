import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class StepAnimation extends StatelessWidget {
  final int step;
  final int total;
  final Color? backgroundColor;
  final Color? loaderColor;
  const StepAnimation({
    super.key,
    required this.step,
    required this.total,
    this.backgroundColor,
    this.loaderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 30.ah,
          child: CircularProgressIndicator(
            backgroundColor: backgroundColor ?? AppColors.rexWhite,
            value: (step / total),
            color: loaderColor ?? AppColors.rexPurpleLight,
            strokeCap: StrokeCap.round,
          ),
        ),
        Text(
          '$step/$total',
          style: AppTextStyles.body3Regular.copyWith(
            color: AppColors.rexPurpleLight,
          ),
        ),
      ],
    );
  }
}
