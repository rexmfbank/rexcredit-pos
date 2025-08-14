import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/bank_statement/widgets/request_bank_statement_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualRequestStatementScreen extends ConsumerWidget {
  const IndividualRequestStatementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.bankStatementTitle,
        subtitle: StringAssets.bankStatementSubtitle,
        onBackButtonPressed: () => context.pop(),
      ),
      body: const RequestBankStatementScreenBody(),
    );
  }
}
