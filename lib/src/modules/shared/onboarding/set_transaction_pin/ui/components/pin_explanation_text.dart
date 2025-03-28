import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PinExplanationText extends StatelessWidget {
  const PinExplanationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetPath.keyPin),
            SizedBox(width: 8.aw),
            const Flexible(
              child: Text(
                StringAssets.pinExplainText2,
                style: TextStyle(color: AppColors.rexGreen2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
