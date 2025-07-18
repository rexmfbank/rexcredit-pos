import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/custom_number_pad_widget.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class PurchaseAmountScreen extends ConsumerWidget {
  const PurchaseAmountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomNumberPadWidget(
      //appBar: AppbarSubScreen(title: 'Enter Amount'),
      appBar: RexAppBar(shouldHaveBackButton: true, title: 'Enter Amount'),
      title: "input digit",
      onChange: (value) {
        ref.read(posCardPurchaseProvider.notifier).setPurchaseAmount(value);
      },
      actionButton: RexElevatedButton(
        onPressed: () async {
          ref
              .read(posCardPurchaseProvider.notifier)
              .validatePurchaseInput(context: context, quickPurchase: false);
        },
        buttonTitle: "Continue",
      ),
    );
  }
}
