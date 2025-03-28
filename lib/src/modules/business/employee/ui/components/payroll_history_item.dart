import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class PayrollHistoryCardItem extends StatelessWidget {
  final String employeeName;
  final String employeeDesignation;
  final VoidCallback onTap;

  const PayrollHistoryCardItem({
    super.key,
    required this.employeeName,
    required this.employeeDesignation,
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
              'assets/png/excel_icon.png',
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
                    Row(
                      children: [
                        Text(
                          employeeDesignation,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.rexTint500),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xffE1F2EE),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Paid',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.rexTint500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.more_vert_rounded,
              size: 18,
              color: AppColors.rexTint500,
            ),
          ],
        ),
      ),
    );
  }
}
