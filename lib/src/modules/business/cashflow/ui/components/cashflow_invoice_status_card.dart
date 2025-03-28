import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class InvoicePaymentStatusCard extends StatelessWidget {
  const InvoicePaymentStatusCard({
    super.key,
    required this.cardBackgroundColor,
    required this.titleText,
    required this.totalText,
  });

  final Color cardBackgroundColor;
  final String titleText;
  final String totalText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text(
                  titleText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  totalText,
                  style: const TextStyle(
                    height: 1.5,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
