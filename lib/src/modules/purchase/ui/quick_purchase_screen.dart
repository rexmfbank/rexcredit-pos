import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/purchase/model/quick_purchase_step.dart';
import 'package:rex_app/src/modules/purchase/ui/purchase_status_screen_body.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/amount_widget.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/amount_widget_topwise.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/quick_purchase_review_body.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/quick_purchase_tip_body.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class QuickPurchaseScreen extends ConsumerStatefulWidget {
  const QuickPurchaseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickPurchaseScreenState();
}

class _QuickPurchaseScreenState extends ConsumerState<QuickPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posCardPurchaseProvider);
    return state.hasReturn
        ? PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              ref.read(posCardPurchaseProvider.notifier).clearState();
            }
          },
          child: AppScaffold(
            isLoading: state.isLoading,
            body:
                state.isTsqChecking
                    ? Center(child: Text("Fetching Status"))
                    : PurchaseStatusScreenBody(),
          ),
        )
        : QuickPurchaseScreenBody();
  }
}

class QuickPurchaseScreenBody extends ConsumerWidget {
  const QuickPurchaseScreenBody({super.key});

  String _titleForStep(QuickPurchaseStep step) {
    switch (step) {
      case QuickPurchaseStep.amount:
        return 'Enter Amount';
      case QuickPurchaseStep.tip:
        return 'Add a Tip?';
      case QuickPurchaseStep.review:
        return 'Review Purchase';
    }
  }

  void _onBack(BuildContext context, WidgetRef ref, QuickPurchaseStep step) {
    final notifier = ref.read(posCardPurchaseProvider.notifier);
    switch (step) {
      case QuickPurchaseStep.amount:
        notifier.clearState();
        context.pop();
      case QuickPurchaseStep.tip:
        notifier.setQuickPurchaseStep(QuickPurchaseStep.amount);
      case QuickPurchaseStep.review:
        notifier.editTip();
    }
  }

  Widget _bodyForStep(QuickPurchaseStep step, String baseappName) {
    switch (step) {
      case QuickPurchaseStep.amount:
        return Pkg.isTopwise(baseappName)
            ? AmountWidgetTopwise(isQuickPurchase: true)
            : AmountWidget(isQuickPurchase: true);
      case QuickPurchaseStep.tip:
        return const QuickPurchaseTipBody();
      case QuickPurchaseStep.review:
        return const QuickPurchaseReviewBody();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    final step = state.quickPurchaseStep;
    return PopScope(
      canPop: step == QuickPurchaseStep.amount,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(posCardPurchaseProvider.notifier).clearState();
          return;
        }
        _onBack(context, ref, step);
      },
      child: AppScaffold(
        isLoading: state.isLoading,
        padding: EdgeInsets.all(0),
        backgroundColor: AppColors.rexBackground,
        appBar: AppbarSubScreen(
          title: _titleForStep(step),
          onBackBtnPress: () => _onBack(context, ref, step),
        ),
        body: _bodyForStep(step, state.baseappName),
      ),
    );
  }
}
