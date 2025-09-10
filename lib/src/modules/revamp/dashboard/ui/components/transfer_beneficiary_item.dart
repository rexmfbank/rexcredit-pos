import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/string_utils.dart';

class TransferBeneficiaryItem extends StatelessWidget {
  final String beneficiaryName;
  final String beneficiaryAccount;
  final String beneficiaryBank;
  final VoidCallback onTap;
  const TransferBeneficiaryItem({
    super.key,
    required this.beneficiaryName,
    required this.beneficiaryAccount,
    required this.beneficiaryBank,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.aw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beneficiaryName.toTitleCase()!,
                      style: AppTextStyles.body2Regular.copyWith(
                        fontSize: 13.asp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.ah),
                    Text(
                      beneficiaryAccount,
                      style: AppTextStyles.body2Regular,
                    ),
                  ],
                ),
                Text(
                  beneficiaryBank.toTitleCase()!,
                  style: AppTextStyles.body2Regular.copyWith(
                    fontSize: 13.asp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.ah),
            const Divider(color: AppColors.rexPurpleLight),
          ],
        ),
      ),
    );
  }
}
