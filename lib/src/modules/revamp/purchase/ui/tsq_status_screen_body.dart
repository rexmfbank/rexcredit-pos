import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/purchase_status_screen_body.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/tsq_success_body.dart';

class TsqStatusScreenBody extends ConsumerStatefulWidget {
  const TsqStatusScreenBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TsqStatusScreenBodyState();
}

class _TsqStatusScreenBodyState extends ConsumerState<TsqStatusScreenBody> {
  @override
  Widget build(BuildContext context) {
    final purchaseState = ref.watch(posCardPurchaseProvider);
    //
    if (purchaseState.isTsqChecking) {
      return Center(child: Text("Confirming Status"));
    } else {
      return purchaseState.needsTsqCheck
          ? TsqSuccessBody()
          : PurchaseStatusScreenBody();
    }
  }
}
