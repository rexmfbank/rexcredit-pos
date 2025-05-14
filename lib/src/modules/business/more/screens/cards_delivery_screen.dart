import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_lga_dropdown.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_state_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CardsDeliveryScreen extends StatefulHookConsumerWidget {
  const CardsDeliveryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardsDeliveryScreenState();
}

class _CardsDeliveryScreenState extends ConsumerState<CardsDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    final addressController = useTextEditingController();
    final landmarkController = useTextEditingController();
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Delivery Details',
        subtitle: 'Where should we deliver your card?',
      ),
      body: ListView(
        children: [
          const CardsStateDropdown(),
          const CardsLgaDropdown(),
          RexTextField(
            outerTitle: 'Full Address',
            hintText: 'Enter Address',
            controller: addressController,
            obscureText: false,
          ),
          RexTextField(
            outerTitle: 'Landmark',
            hintText: 'Nearest bus stop',
            controller: landmarkController,
            obscureText: false,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: RexElevatedButton(
              onPressed: () {
                context.push(
                  "${Routes.dashboardMoreBusiness}/${Routes.cardsDeliveryConfirm}",
                );
              },
              buttonTitle: StringAssets.nextTextOnButton,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
