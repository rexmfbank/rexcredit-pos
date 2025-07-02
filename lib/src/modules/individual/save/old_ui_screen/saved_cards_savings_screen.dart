import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_payment_success_bottom_sheet.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/saved_cards_layout.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SavedCardsSavingsScreen extends ConsumerWidget {
  const SavedCardsSavingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = []; //Add cards

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.savedCardTitle,
        subtitle: StringAssets.savedCardSubtitle,
      ),
      body: ListView(
        children: [
          const SavedCardsLayout(),
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                // Navigator.pushNamed(
                //     context, RouteName.paymentSuccessfulSavings);

                // final authToken = ref.watch(userAuthTokenProvider) ?? 'null';

                // final fundSavingsRequest = FundSavingsPlanRequest(
                //     source: 'card', sourceId: 311, amount: 2000);

                // ref.read(fundSavingsPlanProvider.notifier).fundSavingsPlan(
                //       authToken: authToken,
                //       request: fundSavingsRequest,
                //       planId: "513",
                //     );
                // context.go(RouteName.paymentSuccessfulSavings);

                showSavePaymentSuccessModal(context, 1, "50,000");
              },
              buttonTitle: StringAssets.submitTextOnButton,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
