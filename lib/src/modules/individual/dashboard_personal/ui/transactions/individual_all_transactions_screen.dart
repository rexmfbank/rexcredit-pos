import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/all_transactions_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualAllTransactionsScreen extends ConsumerWidget {
  const IndividualAllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.allTransactionsText,
        subtitle: '',
      ),
      body: AllTransactionsScreenBody(),
    );
  }
}
