import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/components/custom_number_pad_widget.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class QuickPurchaseScreen extends ConsumerStatefulWidget {
  const QuickPurchaseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickPurchaseScreenState();
}

class _QuickPurchaseScreenState extends ConsumerState<QuickPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rexWhite,
      body: CustomNumberPadWidget(
        appBar: AppbarSubScreen(title: 'Enter Amount'),
        title: "input digit",
        onChange: (value) {
          ref.read(posCardPurchaseProvider.notifier).setPurchaseAmount(value);
        },
        actionButton: RexElevatedButton(
          onPressed: () async {
            ref
                .read(posCardPurchaseProvider.notifier)
                .validatePurchaseInput(context: context, quickPurchase: true);
          },
          buttonTitle: "Continue",
        ),
      ),
    );
  }
}
