import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/borrow/components/show_loan_termination_sheet.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_repayment_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/loan_repayment/loan_detail_summary.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoanTerminationScreen extends ConsumerWidget {
  const LoanTerminationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanDetail = ref.watch(fetchLoanDetailProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: 'Loan Termination',
      ),
      body: loanDetail.when(
        data: (data) {
          if (data == null) {
            return const Center(child: Text(StringAssets.loanDetailError2));
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              LoanDetailSummary(loanDetail: data),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: RexElevatedButton(
                  onPressed: () {
                    ref.read(inMemoryLoanDetail.notifier).state = data;
                    showLoanTerminationSheet(context: context);
                  },
                  buttonTitle: StringAssets.loanTermination2,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) =>
            const Center(child: Text(StringAssets.loanDetailError)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
