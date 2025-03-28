import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class FundSavingSheetTitle extends StatelessWidget {
  const FundSavingSheetTitle({
    super.key,
    required this.onTap,
    this.title,
    this.subtitle,
  });

  final void Function()? onTap;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? 'Fund Plan',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.rexPurpleDark,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle ?? 'Choose a payment method',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.rexTint500,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(AssetPath.closeCircularIcon),
          ),
        ),
      ],
    );
  }
}
