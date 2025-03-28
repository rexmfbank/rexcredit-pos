import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/date_utils/change_date_format.dart';

class StartToMaturityDateSavingsCard extends StatelessWidget {
  final String startDate;
  final String maturityDate;

  const StartToMaturityDateSavingsCard({
    Key? key,
    required this.startDate,
    required this.maturityDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
        child: Row(
          children: [
            Image.asset(
              'assets/png/savings_calendar_icon.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Date',
                  style: TextStyle(
                    color: AppColors.rexTint500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  changeDateFormat("yyyy-MM-dd", "dd MMM yyyy", startDate),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 1,
              height: 36,
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maturity Date',
                  style: TextStyle(
                    color: AppColors.rexTint500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  maturityDate,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
