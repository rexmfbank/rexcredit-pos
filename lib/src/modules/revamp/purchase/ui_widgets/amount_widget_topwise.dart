import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/topwise_inputer_dynamic.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class AmountWidgetTopwise extends ConsumerWidget {
  const AmountWidgetTopwise({super.key, required this.isQuickPurchase});

  final bool isQuickPurchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    return Column(
      children: [
        SizedBox(height: 32.ah),
        Padding(
          padding: EdgeInsets.all(16),
          child: TopwiseInputerDynamic(
            textContainerHeight: 50,
            initialValue: state.purchaseAmount,
            onChanged: (value) {
              ref
                  .read(posCardPurchaseProvider.notifier)
                  .setPurchaseAmount(value);
            },
          ),
        ),
        SizedBox(height: 16.ah),
        RexElevatedButton(
          backgroundColor:
              state.isButtonEnabled ? AppColors.rexPurpleLight : AppColors.grey,
          onPressed:
              state.isButtonEnabled
                  ? () => ref
                      .read(posCardPurchaseProvider.notifier)
                      .doInputValidationV2(
                        context: context,
                        quickPurchase: isQuickPurchase,
                      )
                  : null,
          buttonTitle: "Continue",
        ),
      ],
    );
  }
}
