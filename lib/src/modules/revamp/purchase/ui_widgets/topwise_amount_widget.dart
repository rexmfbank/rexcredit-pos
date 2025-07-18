import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/topwise_inputer_dynamic.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class TopwiseAmountWidget extends ConsumerWidget {
  const TopwiseAmountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 32.ah),
        Padding(
          padding: EdgeInsets.all(16),
          child: TopwiseInputerDynamic(
            focusNode: FocusNode(),
            textContainerHeight: 50,
            onChanged: (value) {
              ref
                  .read(posCardPurchaseProvider.notifier)
                  .setPurchaseAmount(value);
            },
          ),
        ),
        SizedBox(height: 16.ah),
        RexElevatedButton(
          onPressed: () {
            ref
                .read(posCardPurchaseProvider.notifier)
                .validatePurchaseInput(context: context, quickPurchase: false);
          },
          buttonTitle: "Continue",
        ),
      ],
    );
  }
}
