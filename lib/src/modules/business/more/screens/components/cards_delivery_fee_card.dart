import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class CardsDeliveryFeeCard extends StatelessWidget {
  const CardsDeliveryFeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.rexWhite,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fee and charges',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleDark,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Issuance Fee'),
                Text('1500'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Maintenance Fee'),
                Text('Free'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
