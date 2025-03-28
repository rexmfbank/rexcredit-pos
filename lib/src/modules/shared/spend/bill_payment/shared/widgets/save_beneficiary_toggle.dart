import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/theme/app_colors.dart';
import '../../../../../../utils/constants/string_assets.dart';

class SaveBeneficiaryToggle extends StatelessWidget {
  const SaveBeneficiaryToggle(
      {super.key, required this.value, required this.onChanged,});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          StringAssets.saveBeneficiary,
          style: TextStyle(
            color: AppColors.rexBlack,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        CupertinoSwitch(
          value: value,
          activeColor: AppColors.rexPurpleLight,
          onChanged: (value) => onChanged(value),
        )
      ],
    );
  }
}
