import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class CardsTrackHeader extends StatelessWidget {
  const CardsTrackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: const Color.fromARGB(255, 229, 244, 237),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(AssetPath.bellIcon),
            const SizedBox(width: 12.0),
            const Flexible(
              child: Text(
                  'Your card is out for delivery. If you have not received it, please call'),
            )
          ],
        ),
      ),
    );
  }
}
