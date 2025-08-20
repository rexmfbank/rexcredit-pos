import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../revamp/utils/config/theme/app_colors.dart';

class NewPageProgressIndicatorBuilder extends StatelessWidget {
  const NewPageProgressIndicatorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 10.h,
        width: 10.w,
        child: CircularProgressIndicator(
          strokeWidth: 2.w,
          color: AppColors.rexPurpleLight,
        ),
      ),
    );
  }
}
