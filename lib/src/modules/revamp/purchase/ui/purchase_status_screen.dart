import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_status_screen_body.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/tsq_status_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';

class PurchaseStatusScreen extends ConsumerWidget {
  const PurchaseStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    debugPrint('Purchase Status Screen Rebuilt');
    debugPrint('Needs TSQ Check: ${state.needsTsqCheck}');
    return AppScaffold(
      isLoading: state.isLoading,
      body:
          state.needsTsqCheck
              ? TsqStatusScreenBody()
              : PurchaseStatusScreenBody(),
    );
  }
}
