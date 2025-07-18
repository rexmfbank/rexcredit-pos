import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/ui/quick_transactions_screen.dart';
import 'package:rex_app/src/modules/revamp/reprinting/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EODFilterResultScreen extends ConsumerStatefulWidget {
  const EODFilterResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EODFilterResultScreenState();
}

class _EODFilterResultScreenState extends ConsumerState<EODFilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    final eodTransactions = ref.watch(eodTransactionsProvider);
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'End-Of-Day Transactions'),
      body: eodTransactions.when(
        data: (data) {
          return Column(
            children: [
              SizedBox(height: 8.ah),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RexFlatButton(
                  backgroundColor: AppColors.rexTint400,
                  onPressed: () {
                    ref
                        .read(reprintProvider.notifier)
                        .printEODv2(context, data);
                  },
                  buttonTitle: "Print Receipts",
                ),
              ),
              SizedBox(height: 16.ah),
              Expanded(
                //height: 150.ah,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return TransactionHistoryItem(
                      trans: data[index],
                      canTap: false,
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(StringAssets.noEODData)),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
