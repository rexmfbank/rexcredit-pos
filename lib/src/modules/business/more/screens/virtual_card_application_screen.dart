import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_delivery_address_card.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_delivery_fee_card.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_delivery_info_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class VirtualCardApplicationScreen extends ConsumerWidget {
  const VirtualCardApplicationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Card Application',
        subtitle: 'Confirm your card details',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: ListView(
          children: [
            const CardDeliveryInfoCard(),
            Card(
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
                      'Account details',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Rex account'),
                        Text('1018289273'),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const CardsDeliveryFeeCard(),
            RexElevatedButton(
              onPressed: () {
                context.go(
                  "${Routes.dashboardMoreBusiness}/${Routes.cards}",
                );
              },
              buttonTitle: 'Confirm and Pay',
              backgroundColor: null,
            ),
          ],
        ),
      ),
    );
  }
}
