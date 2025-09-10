import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmptyBeneficiaryList extends StatelessWidget {
  final String? text;
  final String? loadingText;
  const EmptyBeneficiaryList({
    super.key,
    this.text,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100.ah, horizontal: 60.aw),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              LottieAsset.agreementAnimation,
              height: 200.ah,
            ),
            Text(
              loadingText ?? StringAssets.oopsSorry,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleLight,
                fontSize: 16.asp,
              ),
            ),
            SizedBox(height: 6.ah),
            Text(
              text ?? StringAssets.beneficiaryListEmpty,
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
