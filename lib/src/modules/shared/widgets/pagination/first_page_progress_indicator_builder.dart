import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../revamp/utils/theme/app_colors.dart';

class FirstPageProgressIndicatorBuilder extends StatelessWidget {
  const FirstPageProgressIndicatorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.w,
        color: AppColors.rexPurpleLight,
      ),
    );
  }
}
