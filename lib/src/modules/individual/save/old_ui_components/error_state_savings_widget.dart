import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ErrorStateSavingsScreen extends StatelessWidget {
  const ErrorStateSavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 35),
        SizedBox(
          height: 150,
          child: Image.asset(AssetPath.emptySavingsImage),
        ),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              StringAssets.errorStateSavingsTitle,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleDark,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
