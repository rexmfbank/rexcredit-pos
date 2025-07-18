import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

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
              context.push(
                "${Routes.dashboardIndividual}/${Routes.purchaseAmount}",
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Icon(Icons.credit_card),
            title: Text('Purchase with Cashback'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              context.showToast(message: 'Feature not available');
            },
          ),
        ],
      ),
    );
  }
}
