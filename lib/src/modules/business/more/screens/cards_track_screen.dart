import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_track_address.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_track_header.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class CardsTrackScreen extends StatelessWidget {
  const CardsTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Track card',
        subtitle: 'See where your card is at in realtime',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: [
            const CardsTrackHeader(),
            const CardsTrackAddress(),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.rexWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: ListView(
                  children: const [
                    ListTile(
                      title: Text(
                        'Shipped',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      subtitle: Text(
                        'Your card is ready for delivery. Awaiting courier',
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Ready to Ship',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      subtitle: Text(
                        'Your card is ready and will be shipped soon',
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Shipped',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      subtitle: Text(
                        'Your card is ready and will be shipped soon',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
