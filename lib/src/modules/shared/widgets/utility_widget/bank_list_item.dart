import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui_widgets/uptime_data_widget.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class BankListItem extends StatelessWidget {
  final String bankName;
  final num bankUptimeNo;
  final VoidCallback onTap;

  const BankListItem({
    super.key,
    required this.bankName,
    required this.bankUptimeNo,
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    bankName,
                    style: AppTextStyles.body2Regular.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                UptimeSuccessBadge(rate: bankUptimeNo.toInt()),
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
