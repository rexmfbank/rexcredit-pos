import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class OtpExplanationText extends StatelessWidget {
  const OtpExplanationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.rexLightBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(AssetPath.otpEnvelope),
            const SizedBox(width: 16.0),
            const Flexible(
              child: Text(
                StringAssets.otpExplainText2,
                style: TextStyle(
                  color: AppColors.rexPurpleLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
