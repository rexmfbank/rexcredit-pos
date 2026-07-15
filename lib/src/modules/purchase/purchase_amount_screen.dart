import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/quick_purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/quick_purchase/ui/purchase_status_screen_body.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/amount_widget.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/amount_widget_topwise.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class PurchaseAmountScreen extends ConsumerStatefulWidget {
  const PurchaseAmountScreen({super.key});

  @override
  ConsumerState<PurchaseAmountScreen> createState() =>
      _PurchaseAmountScreenState();
}

class _PurchaseAmountScreenState extends ConsumerState<PurchaseAmountScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posCardPurchaseProvider);
    return state.hasReturn
        ? AppScaffold(
          isLoading: state.isLoading,
          body:
              state.isTsqChecking
                  ? Center(child: Text("Confirming Status"))
                  : PurchaseStatusScreenBody(),
        )
        : PurchaseAmountScreenBody();
  }
}

class PurchaseAmountScreenBody extends ConsumerWidget {
  const PurchaseAmountScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final baseAppName = ref.watch(baseAppNameProvider);
    final state = ref.watch(posCardPurchaseProvider);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(posCardPurchaseProvider.notifier).clearState();
        }
      },
      child: AppScaffold(
        isLoading: state.isLoading,
        padding: EdgeInsets.all(0),
        appBar: RexAppBar(
          shouldHaveBackButton: true,
          title: 'Enter Amount',
          onBackButtonPressed: () {
            ref.read(posCardPurchaseProvider.notifier).clearState();
            context.pop();
          },
        ),
        body:
            state.baseappName == Pkg.topwise ||
                    state.baseappName == Pkg.topwise2
                ? AmountWidgetTopwise(isQuickPurchase: false)
                : AmountWidget(isQuickPurchase: false),
      ),
    );
  }
}
