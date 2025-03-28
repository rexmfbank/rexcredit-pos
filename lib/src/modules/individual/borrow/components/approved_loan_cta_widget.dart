import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/show_accept_loan_model.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import '../../../shared/widgets/modal_bottom_sheets/show_modal_decline_loan.dart';

class ApprovedLoanCtaWidget extends ConsumerWidget {
  const ApprovedLoanCtaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.rexPurpleDark2,
                fixedSize: const Size(150, 55),
                backgroundColor: AppColors.rexWhite,
                side: const BorderSide(color: AppColors.borderGrey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                showModalDeclineLoan(
                  context: context,
                  onPressed: () {
                    context.pop();
                    ref
                        .read(loanApplicationProvider.notifier)
                        .declineApprovedLoan(context);
                  },
                  textController: ref
                      .read(loanApplicationProvider)
                      .loanDeclineReasonController,
                );
                // ref
                //     .read(loanApplicationProvider.notifier)
                //     .onDeclineLoanOffer(context);
              },
              child: const Text(StringAssets.declineOffer),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size(150, 55),
                backgroundColor: AppColors.rexPurpleLight,
                foregroundColor: AppColors.rexWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                showAcceptLoanModal(context: context);
              },
              child: const Text(StringAssets.acceptOffer),
            ),
          ),
        ],
      ),
    );
  }
}
