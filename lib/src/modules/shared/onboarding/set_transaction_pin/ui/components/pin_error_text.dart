import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PinErrorText extends StatelessWidget {
  const PinErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.red3,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(AssetPath.attention),
            const SizedBox(width: 16.0),
            const Flexible(
              child: Text(
                StringAssets.pinErrorText,
                style: TextStyle(
                  color: AppColors.red2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
