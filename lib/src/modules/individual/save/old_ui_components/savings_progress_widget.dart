import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class SavingsProgressWidget extends StatelessWidget {
  final double percentage;

  const SavingsProgressWidget({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = percentage / 100.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Container(
        height: 8.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.rexWhite,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 172, 200, 240),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
