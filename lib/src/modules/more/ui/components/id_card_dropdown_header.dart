import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IdCardDropdownHeader extends StatelessWidget {
  const IdCardDropdownHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            StringAssets.idCardTitle,
            style: AppTextStyles.body1Regular.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.rexPurpleLight,
            ),
          ),
        ),
      ],
    );
  }
}
