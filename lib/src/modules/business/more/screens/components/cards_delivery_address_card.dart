import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class CardsDeliveryAddressCard extends StatelessWidget {
  const CardsDeliveryAddressCard({super.key});

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
              'Contact and Delivery Address',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleDark,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.location_on),
                SizedBox(width: 4),
                Text('52 Bedok Reservoir, Lagos, Nigeria'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.call),
                SizedBox(width: 4),
                Text('+234-810-432-2010')
              ],
            )
          ],
        ),
      ),
    );
  }
}
