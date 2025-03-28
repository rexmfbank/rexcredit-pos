import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class PayrollViewPayslipItem extends StatelessWidget {
  final String iconPath;
  final String employeeName;
  final String netPay;
  final VoidCallback onTap;

  const PayrollViewPayslipItem({
    super.key,
    required this.iconPath,
    required this.employeeName,
    required this.netPay,
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
              width: 50,
              height: 50,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employeeName,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Net Pay: NGN $netPay',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.rexTint500),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'View Payslip',
              style: TextStyle(color: AppColors.cardGrey),
            )
          ],
        ),
      ),
    );
  }
}
