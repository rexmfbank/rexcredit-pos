import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/amount_widget.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/amount_widget_topwise.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class PurchaseAmountScreen extends ConsumerWidget {
  const PurchaseAmountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseAppName = ref.watch(baseAppNameProvider);
    final state = ref.watch(posCardPurchaseProvider);
    return baseAppName == PosPackage.topwise
        ? AppScaffold(
          isLoading: state.isLoading,
          padding: EdgeInsets.all(0),
          appBar: RexAppBar(shouldHaveBackButton: true, title: 'Enter Amount'),
          body: AmountWidgetTopwise(isQuickPurchase: false),
        )
        : AppScaffold(
          isLoading: state.isLoading,
          padding: EdgeInsets.all(0),
          appBar: RexAppBar(shouldHaveBackButton: true, title: 'Enter Amount'),
          body: AmountWidget(isQuickPurchase: false),
        );
  }
}
