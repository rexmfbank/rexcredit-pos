import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/more/bank_statement/business_request_statement_screen.dart';
import 'package:rex_app/src/modules/revamp/transactions/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/endpoints/pos/model/pos_transactions_response.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final check = ref.watch(posTransactionsProvider);
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'Transaction History'),
      body: check.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(child: Text('No Transactions.'));
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return TransactionHistoryItem(trans: data[index]);
            },
          );
        },
        error: (error, _) => Center(child: Text('Cannot show transactions.')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class TransactionHistoryItem extends ConsumerWidget {
  const TransactionHistoryItem({
    super.key,
    required this.trans,
  });

  final PosTransactionsResponseData trans;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 8.0,
      ),
      child: GestureDetector(
        onTap: () {
          ref.read(inMemoryTransactionProvider.notifier).state = trans;
          context.push(Routes.transactionDetail);
        },
        child: Column(
          children: [
            SizedBox(height: 8.ah),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trans.tranUniqRefNo ?? 'N/A',
                      style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.ah),
                    Text(trans.tranDate?.toPosTime() ?? ''),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₦${trans.amount}',
                          style: TextStyle(
                            color: AppColors.rexPurpleDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.ah),
                        Text(
                          trans.paymentStatus ?? 'N/A',
                          style: TextStyle(color: AppColors.rexGreen),
                        )
                      ],
                    ),
                    Icon(
                      Icons.navigate_next_sharp,
                      color: AppColors.rexBlack,
                    )
                  ],
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
