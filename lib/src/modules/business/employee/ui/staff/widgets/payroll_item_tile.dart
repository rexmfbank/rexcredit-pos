import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class PayrollItemTile extends StatelessWidget {
  final String title;
  final String amount;
  const PayrollItemTile({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.ah, left: 16.aw, right: 16.aw),
      padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 8.ah),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.ar),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.ar),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body2Regular.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rexPurpleDark),
                  ),
                  SizedBox(height: 4.ah),
                  Text(
                    double.parse(amount).formatCurrencyNum(),
                    style: AppTextStyles.body1Regular.copyWith(
                      fontSize: 13.asp,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
