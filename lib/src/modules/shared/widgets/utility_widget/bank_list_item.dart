import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class BankListItem extends StatelessWidget {
  final String bankName;
  final VoidCallback onTap;
  const BankListItem({
    super.key,
    required this.bankName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.aw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankName,
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5.ah),
            const Divider(color: AppColors.rexPurpleLight),
          ],
        ),
      ),
    );
  }
}
