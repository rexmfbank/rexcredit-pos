import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class InvestmentTypeCard extends StatelessWidget {
  final String iconPath;
  final String investmentTitle;
  final String investmentSubTitle;
  final bool isCompleted;
  final VoidCallback onTap;

  const InvestmentTypeCard({
    super.key,
    required this.iconPath,
    required this.investmentTitle,
    required this.investmentSubTitle,
    this.isCompleted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
          left: 16,
          right: 16,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted ? AppColors.cardBrown : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      investmentTitle,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isCompleted
                              ? AppColors.rexBrown2
                              : AppColors.rexPurpleDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      investmentSubTitle,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isCompleted
                              ? AppColors.rexBrown2
                              : AppColors.rexPurpleDark),
                    ),
                  ],
                ),
              ),
            ),
            isCompleted
                ? Image.asset(
                    AssetPath.checkedIcon,
                    width: 30,
                    height: 30,
                  )
                : const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.rexTint500,
                  ),
          ],
        ),
      ),
    );
  }
}
