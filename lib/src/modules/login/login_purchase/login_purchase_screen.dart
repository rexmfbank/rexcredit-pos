import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/purchase/ui/purchase_status_screen_body.dart';
import 'package:rex_app/src/modules/purchase/ui/quick_purchase_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class LoginPurchaseScreen extends ConsumerStatefulWidget {
  const LoginPurchaseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginPurchaseScreenState();
}

class _LoginPurchaseScreenState extends ConsumerState<LoginPurchaseScreen> {
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
                    : PurchaseStatusScreenBody(outside: false),
          ),
        )
        : QuickPurchaseScreenBody();
  }
}
