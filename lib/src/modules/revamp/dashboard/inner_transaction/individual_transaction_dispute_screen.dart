import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/inner_transaction/transaction_dispute_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualTransactionDisputeScreen extends ConsumerWidget {
  const IndividualTransactionDisputeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexBackground,
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
