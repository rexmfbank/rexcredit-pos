import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/borrow/components/show_loan_part_payment_sheet.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_repayment_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/loan_repayment/loan_detail_summary.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoanPartPaymentScreen extends ConsumerWidget {
  const LoanPartPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanDetail = ref.watch(fetchLoanDetailProvider);
    final loanRepayment = ref.watch(loanRepaymentProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: 'Loan Part Payment',
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
              RexTextField(
                controller: loanRepayment.amountController,
                outerTitle: StringAssets.loanPartPayment,
                showOuterTile: true,
                hintText: StringAssets.enterAmount,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: RexElevatedButton(
                  onPressed: () {
                    if (ref
                        .read(loanRepaymentProvider.notifier)
                        .validateLoanPartPayment(context)) {
                      showLoanPartPaymentSheet(context);
                    }
                  },
                  buttonTitle: 'Make payment',
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
