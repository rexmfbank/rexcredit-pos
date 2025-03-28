import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SelectCountryAppBarTitle extends StatelessWidget {
  const SelectCountryAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringAssets.selectCountry,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.rexPurpleDark,
            fontSize: 22,
          ),
        ),
        Text(
          StringAssets.selectCountry2,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.rexTint500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
