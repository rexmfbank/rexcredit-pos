import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class LoanProductCard extends StatelessWidget {
  final String iconPath;
  final String loanProductTitle;
  final String loanProductSubTitle;
  final VoidCallback onTap;

  const LoanProductCard({
    super.key,
    required this.iconPath,
    required this.loanProductTitle,
    required this.loanProductSubTitle,
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
          color: Colors.white,
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
                      loanProductTitle,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loanProductSubTitle,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.rexTint500),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
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
