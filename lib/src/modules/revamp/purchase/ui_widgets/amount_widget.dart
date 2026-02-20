import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/custom_number_pad_widget.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class AmountWidget extends ConsumerWidget {
  const AmountWidget({super.key, required this.isQuickPurchase});

  final bool isQuickPurchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    return CustomNumberPadWidget(
      title: "input digit",
      onChange: (value) {
        ref.read(posCardPurchaseProvider.notifier).setPurchaseAmount(value);
      },
      actionButton: RexElevatedButton(
        backgroundColor:
            state.isButtonEnabled ? AppColors.rexPurpleLight : AppColors.grey,
        onPressed:
            state.isButtonEnabled
                ? () => ref
                    .read(posCardPurchaseProvider.notifier)
                    .doInputValidation(
                      context: context,
                      quickPurchase: isQuickPurchase,
                    )
                : null,
        buttonTitle: "Continue",
      ),
    );
  }
}
