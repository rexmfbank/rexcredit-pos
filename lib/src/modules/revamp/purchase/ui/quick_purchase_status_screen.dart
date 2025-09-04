import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_status_screen_body.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';

class QuickPurchaseStatusScreen extends ConsumerWidget {
  const QuickPurchaseStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(posCardPurchaseProvider).isLoading,
      body: PurchaseStatusScreenBody(),
    );
  }
}
