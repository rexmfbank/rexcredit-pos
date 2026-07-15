import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/transactions/widgets/all_transactions_detail_screen_body.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class IndividualTransactionDetailScreen extends ConsumerWidget {
  const IndividualTransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: Strings.transactionDetailText,
      ),
      body: TransactionDetailScreenBody(),
    );
  }
}
