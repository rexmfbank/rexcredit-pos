import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/reprinting/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class ReprintScreen extends ConsumerWidget {
  const ReprintScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: RexAppBar(shouldHaveBackButton: true, title: 'Reprint'),
      body: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Icon(Icons.credit_card),
            title: Text('Print End Of Day (EOD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              ref.read(reprintProvider.notifier).fetchTransactionList();
              context.push(
                "${Routes.dashboardIndividual}/${Routes.eodInsideScreen}",
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Icon(Icons.credit_card),
            title: Text('Print EOD by date'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              context.showToast(message: "Sorry, not yet available.");
            },
          ),
        ],
      ),
    );
  }
}
