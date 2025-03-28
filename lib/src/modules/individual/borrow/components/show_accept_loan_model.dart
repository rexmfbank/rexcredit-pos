import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_pin_dialog.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/fund_saving_sheet_title.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

void showAcceptLoanModal({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) => Consumer(
      builder: (context, ref, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FundSavingSheetTitle(
                  title: 'Confirm Loan Offer',
                  subtitle: 'Input Transaction PIN to accept',
                  onTap: () => context.pop(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      const Text(
                        'Yes, I have read the offer letter and will accept loan',
                      ),
                      const SizedBox(height: 8.0),
                      Center(
                        child: RexElevatedButton(
                          buttonTitle: 'Confirm Acceptance',
                          onPressed: () {
                            showTransferPinModalSheet(
                              context: context,
                              onPinEntered: (p0) {
                                ref
                                    .read(loanApplicationProvider.notifier)
                                    .acceptApprovedLoan(context, p0);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
