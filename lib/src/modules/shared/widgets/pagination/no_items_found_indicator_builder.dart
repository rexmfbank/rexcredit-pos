import 'package:flutter/material.dart';

import '../../../revamp/utils/theme/app_colors.dart';
import '../../../../utils/constants/app_text_styles.dart';

class NoItemsFoundIndicatorBuilder extends StatelessWidget {
  const NoItemsFoundIndicatorBuilder({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTextStyles.h2.copyWith(
          color: AppColors.rexPurpleLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
