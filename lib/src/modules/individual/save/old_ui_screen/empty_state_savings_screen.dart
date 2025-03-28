import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmptyStateSavingsScreen extends StatelessWidget {
  const EmptyStateSavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
              StringAssets.zeroStateSavingsTitle2,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexGreen,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 96.0, right: 96.0),
            child: Text(
              StringAssets.zeroStateSavingsSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.rexTint500,
                height: 1.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            left: 104.0,
            right: 104.0,
          ),
          child: RexFlatButton(
            onPressed: () {},
            buttonTitle: StringAssets.createSavingsTextOnButton,
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
