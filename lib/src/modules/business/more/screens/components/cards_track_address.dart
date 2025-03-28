import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class CardsTrackAddress extends StatelessWidget {
  const CardsTrackAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.rexWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.location_on),
                SizedBox(width: 12),
                Flexible(
                  child: Text('52 Bedok Reservoir, Lagos, Nigeria'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.call),
                SizedBox(width: 12),
                Text('+234-810-432-2010')
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.send),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Courier: Gokada'),
                    SizedBox(height: 4.0),
                    Text('Waybill'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
