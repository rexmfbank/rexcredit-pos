import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/transaction_dispute_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessTransactionDisputeScreen extends ConsumerWidget {
  const BusinessTransactionDisputeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.reportTransactionText2,
        subtitle: '',
        step: null,
      ),
      body: TransactionDisputeScreenBody(),
    );
  }
}
