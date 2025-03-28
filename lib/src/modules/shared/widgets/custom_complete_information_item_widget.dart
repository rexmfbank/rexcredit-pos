import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class CustomCompleteInfoItemCard extends StatelessWidget {
  final String investmentTitle;
  final String investmentSubTitle;
  final VoidCallback onTap;

  const CustomCompleteInfoItemCard({
    super.key,
    required this.investmentTitle,
    required this.investmentSubTitle,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      investmentTitle,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      investmentSubTitle,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.rexTint500),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
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
