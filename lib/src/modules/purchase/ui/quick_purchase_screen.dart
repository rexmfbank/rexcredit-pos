import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/amount_widget.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/amount_widget_topwise.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/app_preference_provider.dart';
import 'package:rex_app/src/shared/page_widgets/app_scaffold.dart';

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
          body: AmountWidgetTopwise(),
        )
        : AppScaffold(
          isLoading: state.isLoading,
          padding: EdgeInsets.all(0),
          appBar: AppbarSubScreen(title: 'Enter Amount'),
          body: AmountWidget(),
        );
  }
}
