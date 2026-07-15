import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class PurchaseOptionScreen extends ConsumerWidget {
  const PurchaseOptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: RexAppBar(shouldHaveBackButton: true, title: 'Purchase'),
      body: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Icon(Icons.credit_card),
            title: Text('Purchase'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              ref.read(posCardPurchaseProvider.notifier).initializeData();
              context.push("${Routes.dashboardHome}/${Routes.purchaseAmount}");
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Icon(Icons.credit_card),
            title: Text('Purchase with Cashback'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              context.showSnack(message: 'Feature not available');
            },
          ),
        ],
      ),
    );
  }
}
