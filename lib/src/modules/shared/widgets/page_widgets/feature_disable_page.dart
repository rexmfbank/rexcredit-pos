import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class FeatureDisablePage extends StatelessWidget{
  final String? title;
  final String? subtitle;
  final Alignment? alignment;
  const FeatureDisablePage({
    super.key,
    this.title,
    this.subtitle,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.ah),
      child: Align(
        alignment: alignment ?? Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              LottieAsset.featureDisabled,
              height: 300.ah,
            ),
            Text(
              title ?? StringAssets.oopsSorry,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleLight,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 6.ah),
            Text(
              subtitle ?? StringAssets.featureDisabled,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.asp,
                color: AppColors.rexTint500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

}