import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_delivery_address_card.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_delivery_fee_card.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_delivery_info_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class CardsDeliveryConfirmScreen extends ConsumerWidget {
  const CardsDeliveryConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Confirm Delivery Details',
        subtitle: 'Where your card will be delivered',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: ListView(
          children: [
            const CardDeliveryInfoCard(),
            const CardsDeliveryAddressCard(),
            const CardsDeliveryFeeCard(),
            RexElevatedButton(
              onPressed: () {
                context.go(
                  "${RouteName.dashboardMoreBusiness}/${RouteName.cards}",
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
