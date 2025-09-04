import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/topwise_amount_widget.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/custom_number_pad_widget.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
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
    final baseAppName = ref.watch(baseAppNameProvider);
    final state = ref.watch(posCardPurchaseProvider);
    return baseAppName == PosPackage.topwise
        ? AppScaffold(
          isLoading: state.isLoading,
          padding: EdgeInsets.all(0),
          appBar: AppbarSubScreen(title: 'Enter Amount'),
          body: TopwiseAmountWidget(isQuickPurchase: true),
        )
        : AppScaffold(
          isLoading: state.isLoading,
          padding: EdgeInsets.all(0),
          body: CustomNumberPadWidget(
            appBar: AppbarSubScreen(title: 'Enter Amount'),
            title: "input digit",
            onChange: (value) {
              ref
                  .read(posCardPurchaseProvider.notifier)
                  .setPurchaseAmount(value);
            },
            actionButton: RexElevatedButton(
              onPressed: () async {
                ref
                    .read(posCardPurchaseProvider.notifier)
                    .validatePurchaseInput(
                      context: context,
                      quickPurchase: true,
                    );
              },
              buttonTitle: "Continue",
            ),
          ),
        );
  }
}
