import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/components/custom_number_pad_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class PurchaseAmountScreen extends ConsumerWidget {
  const PurchaseAmountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomNumberPadWidget(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: "Enter Amount",
        showProfileImage: false,
      ),
      title: "input digit",
      onChange: (value) {
        ref.read(posCardPurchaseProvider.notifier).setPurchaseAmount(value);
      },
      actionButton: RexElevatedButton(
        onPressed: () async {
          ref
              .read(posCardPurchaseProvider.notifier)
              .cardPurchase(context: context, quickPurchase: false);
        },
        buttonTitle: "Continue",
      ),
    );
  }
}
