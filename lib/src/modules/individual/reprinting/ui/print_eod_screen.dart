import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/reprinting/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

class PrintEodScreen extends ConsumerWidget {
  const PrintEodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTransact = ref.watch(userRecentTransactionProvider(
      const RecentTransactionParam(startDate: '', endDate: ''),
    ));
    final reprintState = ref.watch(reprintProvider);
    //
    return AppScaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: "Print EOD",
        showProfileImage: false,
      ),
      body: Column(
        children: [
          Text("Today's Date: "),
          Text(DateTime.now().dateReadable()),
          recentTransact.when(
            data: (List<TransferData>? data) {
              if (data == null) {
                return Text("No data");
              }
              // final numbers = data.where(
              //   (value) => value.transactionDate
              //       ?.dateYYYYMMDD()
              //       .startsWith(reprintState.todaysDate),
              // );
              // final n = numbers.length;
              // return Text("You have $numbers recent transactions");
            },
            error: (error, _) => Text("Could not get number of transactions"),
            loading: () => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      ),
    );
  }
}
