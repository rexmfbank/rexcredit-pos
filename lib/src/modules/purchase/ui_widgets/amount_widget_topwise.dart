import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/topwise_inputer_dynamic.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

class AmountWidgetTopwise extends ConsumerWidget {
  const AmountWidgetTopwise({super.key, required this.isQuickPurchase});

  final bool isQuickPurchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    return Column(
      children: [
        SizedBox(height: 32.ah),
        Expanded(
          child: Padding(
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
        ),
        Spacer(),
        SafeArea(
          child: RexElevatedButton(
            backgroundColor:
                state.isButtonEnabled
                    ? AppColors.rexPurpleLight
                    : AppColors.grey,
            onPressed:
                state.isButtonEnabled
                    ? () => ref
                        .read(posCardPurchaseProvider.notifier)
                        .doInputValidation(quickPurchase: isQuickPurchase)
                    : null,
            buttonTitle: "Continue",
          ),
        ),
      ],
    );
  }
}
