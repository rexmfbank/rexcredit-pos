import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_management_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_due_date_item.dart';

class RepaymentDateListWidget extends ConsumerWidget {
  const RepaymentDateListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: SizedBox(
        height: 105,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ref
              .watch(loanManagementProvider)
              .loanDetail
              ?.repaymentSchedule
              ?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: LoanDueDateItem(
                  repaymentDateData: ref
                      .watch(loanManagementProvider)
                      .loanDetail
                      ?.repaymentSchedule?[index]),
            );
          },
        ),
      ),
    );
  }
}
