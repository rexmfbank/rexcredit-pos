import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/utils/routes/routes_imports.dart';
import 'package:rex_app/src/shared/page_widgets/app_scaffold.dart';

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
              context.push(
                "${Routes.dashboardIndividual}/${Routes.eodInsideScreen}",
              );
            },
          ),
        ],
      ),
    );
  }
}
