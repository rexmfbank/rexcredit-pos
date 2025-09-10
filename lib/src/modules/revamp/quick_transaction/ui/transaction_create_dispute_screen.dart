import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/trans_dispute_notifier.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/ui/quick_transactions_detail_screen.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class TransactionCreateDisputeScreen extends ConsumerStatefulWidget {
  const TransactionCreateDisputeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionCreateDisputeScreenState();
}

class _TransactionCreateDisputeScreenState
    extends ConsumerState<TransactionCreateDisputeScreen> {
  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(inMemoryTransactionProvider);
    final disputeProvider = ref.watch(transDisputeProvider);
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.all(0),
      isLoading: disputeProvider.isLoading,
      backgroundColor: AppColors.rexBackground,
      appBar: AppbarSubScreen(title: "Report Transaction"),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          QuickTransactionsDetailSummary(posTransaction: detail),
          SizedBox(height: 16.ah),
          RexTextField(
            controller: disputeProvider.textController,
            outerTitle: 'Enter a message',
            showOuterTile: true,
            textFieldIsRequired: true,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: RexElevatedButton(
              onPressed: () {
                ref.read(transDisputeProvider.notifier).validateInput(context);
              },
              buttonTitle: 'Submit Report',
            ),
          ),
        ],
      ),
    );
  }
}
