import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_savings_duration_slider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CardsSpendLimitScreen extends StatefulHookConsumerWidget {
  const CardsSpendLimitScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardsSpendingLimitScreenState();
}

class _CardsSpendingLimitScreenState
    extends ConsumerState<CardsSpendLimitScreen> {
  @override
  Widget build(BuildContext context) {
    final amountController = useTextEditingController();
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Set spending limit',
        subtitle: 'Adjust the slider below to set your preferred limit',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: AppColors.rexWhite,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RexTextField(
                      outerTitle: 'Amount',
                      hintText: 'Enter amount',
                      controller: amountController,
                      obscureText: false,
                    ),
                    CustomSavingsDurationSlider(
                      min: 10,
                      max: 100,
                      value: 50,
                      onChanged: (cValue) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          RexElevatedButton(
            onPressed: () {
              context
                  .go("${RouteName.dashboardMoreBusiness}/${RouteName.cards}");
            },
            buttonTitle: StringAssets.saveTextOnButton,
            backgroundColor: null,
          ),
        ],
      ),
    );
  }
}
