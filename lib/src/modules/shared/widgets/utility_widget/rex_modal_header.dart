import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_cancel_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class RexModalHeader extends StatelessWidget{
  final String title;
  const RexModalHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.h3.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.rexPurpleLight,
          ),
        ),
        const RexCancelButton(),
      ],
    );
  }

}