import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../utils/constants/app_text_styles.dart';

class FirstPageIndicatorErrorBuilder extends StatelessWidget {
  const FirstPageIndicatorErrorBuilder({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: AppTextStyles.h2.copyWith(
          color: AppColors.rexPurpleLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );;
  }
}
